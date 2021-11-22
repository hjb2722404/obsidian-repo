Hijacking HTML canvas and PNG images to store arbitrary text data     | Igor Kromin

[Igor Kromin  *|*   Consultant*.*  Coder*.*  Blogger*.*  Tinkerer*.*  Gamer*.*](https://www.igorkromin.net/)

[Start Here](https://www.igorkromin.net/)**[Blog](https://www.igorkromin.net/blog)**[FAQ](https://www.igorkromin.net/faq)**[Contact](https://www.igorkromin.net/contact)

### [Hijacking HTML canvas and PNG images to store arbitrary text data](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/)

**   6-Sep-2018

One of the web app projects I'm working on had an interesting requirement recently - it needed to provide a save/load feature without relying on cookies, local storage or server side storage (no accounts or logins). My first pass at the save feature implementation was to take my data, serialise it as JSON, dynamically create a new link element with a [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) and the [download attribute](https://www.w3schools.com/Tags/att_a_download.asp) set and trigger a click event on this link. That worked pretty well on desktop browsers. It failed miserably on mobile Safari.

**Problem** - Mobile Safari ignores the download attribute in the link element. This leads to the serialised JSON data being displayed in the browser window without any way of storing it on the user's device. There was no way to disable this.

**Solution** - Present the user with something that stores data and that they can save to their device. An image is an obvious choice here. This doesn't create the same save/load experience but is close enough to be workable.

*I did try using QR codes for this and found them incredibly easy to generate but the decoding side was not so simple and required rather large libraries to be included, so I quickly discarded the idea of using them.*

The challenge then was to work out how to store arbitrary text data in a PNG. This was not a new idea and has been [done](https://www.iamcal.com/png-store/)  [previously](https://github.com/dbohdan/s2png), however I didn't want to have a completely generic storage container and was happy to impose some constraints to make my job easier.

**Constraints/Requirements**

1.  The generated image had to be easy to save and should have preset dimensions.

2.  The save/load data I was dealing with was in the order of several dozen kilobytes.

3.  I wanted to store my data as JSON.

4.  I didn't want to deal with the details saving/loading in any particular image format.

Sounds simple enough right? Well there were a few catches. But first lets see the general approach.

Images are fundamentally 2D arrays of pixels. Each pixel is a tuple of 3 bytes, one for each colour component - RGB. Each of the colour components has a range of 0 to 255. This lends itself to storing byte/character arrays naturally. For example a single pixel can be used to store the array of ASCII characters ['F', 'T', 'W'] by encoding their ASCII codes as a colour intensity like so...

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141214.png)](https://www.igorkromin.net/fp-content/images/programming/pngdata/pngdata_1.png)

The result is a rather grey and boring pixel but it stores the data we want. Whole sentences can be encoded in the same manner - *"The quick brown fox jumps over the lazy dog"* - is a sequence of these ASCII codes...

 Text
1
84	104	101
2
32	113	117
3
105	99	107
4
32	98	114
5
111	119	110
6
32	102	111
7
120	32	106
8
117	109	112
9
115	32	111
10
118	101	114
11
32	116	104
12
101	32	108
13
97	122	121
14
32	100	111
15
103

Which ends up as 15 pixels like so...

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141220.png)](https://www.igorkromin.net/fp-content/images/programming/pngdata/pngdata_2.png)

The last 3-tuple only has one character code so it is padded with two zero values to produce the resulting pixel.

That was the basic approach. Then I had to address my requirements:

1.  Though storing and generating an image that was a 1-pixel line would have been the easiest to implement, this is not easy to tap to save so I had to use a square image of sufficient size. Using a preset maximum size (256 x 256 pixels) of the image worked well towards this but it required keeping track of the size of the actual encoded data. This encoded size was the length of a square and had to be stored in the generated image. Using a single colour of the first pixel would let me have a square of up to 255 x 255 in size - the first line is forfeited to store this size value and since it's a square the last column in the image is also forfeited. The size of the byte/character array being encoded also had to be preserved somehow, this would require more than a byte of storage to store but I had the remainder of the first line worth of pixels to deal with this (which I didn't end up needing due to a fortunate issue I encountered with the alpha channel).

2.  Since the maximum size of the available pixel data was 255 x 255 pixels, this gave me 65025 pixels to play with. In turn this translated to 195075 bytes (190kB) of text data. This was well above what I actually needed.

3.  Using [TextEncoder](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder) I could convert my serialised JSON data into a byte array (Uint8Array in JavaScript).

4.  Using an off-screen [canvas](https://www.w3schools.com/html/html5_canvas.asp) would allow me to manipulate pixel data at will and then convert to an image data URL in my desired format.

**Converting objects to a byte array**

So now I had the general approach worked out and had a container for my byte array. The next step was to convert my objects into a form that could be stored in a byte array. This was easy, using [JSON.stringify()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) and [TextEncoder.encode()](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder/encode) I could get a ***Uint8Array***. I could also then work out the size of the square image that would be big enough to store this data.

 JavaScript
1
var strData = JSON.stringify(myObjData);
2
var uint8array = (new TextEncoder('utf-8')).encode(strData);
3

4
var dataSize = Math.ceil(Math.sqrt(uint8array.length / 3));

**Converting byte array to an image data**

Then it was time to take my byte array data and convert it into an [ImageData](https://developer.mozilla.org/en-US/docs/Web/API/ImageData) object that could be used with a *canvas*. That's where I came across the first issue - *ImageData* expected a [Uint8ClampedArray](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8ClampedArray) and I had a [Uint8Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array). Fundamentally though since my data was already 'clamped' in a sense by the *TextEncoder* conversion I didn't really have to worry too much.

Since I needed a lossless format to store my image data I went for PNG as the output format. This also meant that instead of storing data as RGB, it would be stored as RGBA. There was an additional Alpha channel per pixel and therefore an extra byte to play with. However after some experimentation I ran into an issue that had to do with [RGB corruption when the alpha channel was set to zero](https://stackoverflow.com/questions/22384423/canvas-corrupts-rgb-when-alpha-0).

That threw a spanner in the works and I had to write code to convert my 3-tuple byte array into a 4-tuple array with the 4th (alpha) component being set to full opacity (255). This turned out to be an advantage for decoding later since I could skip all zero-padded data easily. It wasn't the most efficient code but it did the trick.

 JavaScript
1
var paddedData = new  Uint8ClampedArray(dataSize * dataSize * 4);
2
var idx = 0;
3
for (var i = 0; i < uint8array.length; i += 3) {
4
 var subArray = uint8array.subarray(i, i + 3);
5
paddedData.set(subArray, idx);
6
paddedData.set([255], idx + 3);
7
idx += 4;
8
}

As a bonus I now had the correctly typed ***Uint8ClampedArray*** byte array and could finally construct my ***ImageData*** object.

 JavaScript
1
var imageData = new ImageData(paddedData, dataSize, dataSize);

**Drawing the image**

With the ***ImageData*** object available I could now create a *canvas* and draw the image data that was holding my encoded JSON. First the canvas was created 'off screen' and its context retrieved and the background set to a solid colour (actual colour doesn't matter here).

 JavaScript
1
var imgSize = 256;
2
var canvas = document.createElement('canvas');
3
canvas.width = canvas.height = imgSize;
4
var ctx = canvas.getContext('2d');
5

6
ctx.fillStyle = '#AA0000';
7
ctx.fillRect(0, 0, imgSize, imgSize);

Then I could 'draw' the pixel that represented the size of the square image that encoded my data.

 JavaScript
1
ctx.fillStyle = 'rgb(' + dataSize +',0,0)';
2
ctx.fillRect(0, 0, 1, 1);

Then I could draw the image data...
 JavaScript
1
ctx.putImageData(imageData, 0, 1);

**Saving the image**

The image could now be saved from the *canvas* to the file system (or in the case of mobile Safari displayed in a new tab) with a bit of *jQuery* code...

 JavaScript
1
$('body').append('<a id="hiddenLink" href="' + canvas.toDataURL() +
2
 '" style="display:none;" download="image.png">Download</a>');
3
var link = $('#hiddenLink')[0];
4
link.click();
5
link.remove();

The end result was something like this...
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141225.png)

Of course the next step is decoding an image and getting the original JSON back out of it, that will have to wait until the next article however, which is available now - [Retrieving data from hijacked PNG images using HTML canvas and Javascript](https://www.igorkromin.net/index.php/2018/09/20/retrieving-data-from-hijacked-png-images-using-html-canvas-and-javascript/)!

-i

[Skip down to comments...](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comments)

Hope you found this post useful...

...so please read on! I love writing articles that provide beneficial information, tips and examples to my readers. All information on my blog is provided free of charge and I encourage you to share it as you wish. There is a small favour I ask in return however - engage in comments below, provide feedback, and if you see mistakes [let me know](https://www.igorkromin.net/contact).

If you want to show additional support and help me pay for web hosting and domain name registration,[donations](http://paypal.me/ikromin), no matter how small, are always welcome!

Use of any information contained in this blog post/article is subject to [this disclaimer](https://www.igorkromin.net/disclaimer).

[**](http://kr0m.in/BTComwB)

 **  [Programming](https://www.igorkromin.net/index.php/category/programming/), [HTML](https://www.igorkromin.net/index.php/category/html/), [JavaScript](https://www.igorkromin.net/index.php/category/javascript/)

**   Igor Kromin
[ ]()

What do you think?
13 Responses
![upvote-512x512.png](../_resources/828101660ed17b0761c95e89f9e367d4.png)
Upvote
![funny-512x512.png](../_resources/80ec843281e6130a88e665c83c2c12d5.png)
Funny
![love-512x512.png](../_resources/11d71f65e58bb5c9afb8534ba31c6f75.png)
Love
![surprised-512x512.png](../_resources/13431b9bca0ec3070b4277d7162d0755.png)
Surprised
![angry-512x512.png](../_resources/d2e29b214b10de327b89d7197a7b68e1.png)
Angry
![sad-512x512.png](../_resources/e84a77b79c9a1423d57ef6cf7f6bb2d9.png)
Sad

- [4 comments]()
- [**Igor's Blog**](https://disqus.com/home/forums/ikrominblog/)
- [Login](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
- [1](https://disqus.com/home/inbox/)
- [ Recommend](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
- tTweetfShare
- [Sort by Newest](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)

![noavatar92.7b2fde640943965cc88df0cdee365907.png](../_resources/7b2fde640943965cc88df0cdee365907.png)

Join the discussion…

- [Attach](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)

###### Log in with

-
-
-
-

######  or sign up with Disqus

?

### Disqus is a discussion network

- Disqus never moderates or censors. The rules on this community are its own.
- Don't be a jerk or do anything illegal. Everything is easier that way.

[Read full terms and conditions](https://docs.disqus.com/kb/terms-and-policies/)

-

    - [−](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
    - [*⚑*](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)

[![avatar92.jpg](../_resources/1c0fa161b30627b8299fd88aab890aea.jpg)](https://disqus.com/by/MatthewRayfield/)

 [Matthew Rayfield](https://disqus.com/by/MatthewRayfield/)    •  [17 days ago](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4147063876)

I really like this idea ! Question though: I did a little test in iOS and it seems like it opens up a new tab with the image and then the user has to save it from there. Is this how yours works to ?

    -
    
        - [−](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
        - [*⚑*](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)

[![avatar92.jpg](../_resources/5a5306be2d6df501bb7020656ce8218e.jpg)](https://disqus.com/by/ikromin/)

 [Igor's Blog](https://disqus.com/by/ikromin/)  Mod  [*>* Matthew Rayfield](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4147063876)  •  [17 days ago](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4147347028)

Thanks! Unfortunately yes, on mobile Safari that's how it is because there's no auto-download available. The reason I went with the image is exactly because of this, you can tap an image and save it easily, you can't if you just output a bunch of JSON. :)

        -
    
            - [−](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
            - [*⚑*](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)

[![avatar92.jpg](../_resources/1c0fa161b30627b8299fd88aab890aea.jpg)](https://disqus.com/by/MatthewRayfield/)

 [Matthew Rayfield](https://disqus.com/by/MatthewRayfield/)    [*>* Igor's Blog](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4147347028)  •  [9 days ago](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4159869533)

Ah okay. Well it's a cool solution regardless of Mobile Safari's quirks !

            -
    
                - [−](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
                - [*⚑*](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)

[![avatar92.jpg](../_resources/5a5306be2d6df501bb7020656ce8218e.jpg)](https://disqus.com/by/ikromin/)

 [Igor's Blog](https://disqus.com/by/ikromin/)  Mod  [*>* Matthew Rayfield](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4159869533)  •  [8 days ago](https://www.igorkromin.net/index.php/2018/09/06/hijacking-html-canvas-and-png-images-to-store-arbitrary-text-data/#comment-4161132767)

Thanks

- [Powered by Disqus](https://disqus.com/)
- [*✉*Subscribe*✔*](https://disqus.com/embed/comments/?base=default&f=ikrominblog&t_i=entry180906-134439&t_u=https%3A%2F%2Fwww.igorkromin.net%2Findex.php%2F2018%2F09%2F06%2Fhijacking-html-canvas-and-png-images-to-store-arbitrary-text-data%2F&t_e=&t_d=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&t_t=Hijacking%20HTML%20canvas%20and%20PNG%20images%20to%20store%20arbitrary%20text%20data%20%7C%20Igor%20Kromin&s_o=default#)
- [*d*Add Disqus to your site](https://publishers.disqus.com/engage?utm_source=ikrominblog&utm_medium=Disqus-Footer)
- [**Disqus' Privacy Policy](https://help.disqus.com/customer/portal/articles/466259-privacy-policy)

Other posts you may like...

![](../_resources/0ec07fca9e51eafddb4425111e83b89a.png)
Hi! You can search my blog here ⤵

Or browse the recent top tags...

[Programming](https://www.igorkromin.net/index.php/category/programming/)249  [Java](https://www.igorkromin.net/index.php/category/java/)103  [Error](https://www.igorkromin.net/index.php/category/error/)58  [SoapUI](https://www.igorkromin.net/index.php/category/soapui/)11  [Testing](https://www.igorkromin.net/index.php/category/testing/)17  [Tips](https://www.igorkromin.net/index.php/category/tips/)110  [Git](https://www.igorkromin.net/index.php/category/git/)9  [SQL](https://www.igorkromin.net/index.php/category/sql/)27  [Apple](https://www.igorkromin.net/index.php/category/apple/)148  [macOS](https://www.igorkromin.net/index.php/category/macos/)36  [WebServices](https://www.igorkromin.net/index.php/category/webservices/)42  [Oracle](https://www.igorkromin.net/index.php/category/oracle/)57  [WebLogic](https://www.igorkromin.net/index.php/category/weblogic/)46  [Review](https://www.igorkromin.net/index.php/category/review/)107  [MetalEarth](https://www.igorkromin.net/index.php/category/metalearth/)10  [JUnit](https://www.igorkromin.net/index.php/category/junit/)6  [Mac](https://www.igorkromin.net/index.php/category/mac/)16  [SQLDeveloper](https://www.igorkromin.net/index.php/category/sqldeveloper/)6  [JavaScript](https://www.igorkromin.net/index.php/category/javascript/)43  [HTML](https://www.igorkromin.net/index.php/category/html/)58  [Performance](https://www.igorkromin.net/index.php/category/performance/)5

#### Tweets

#### Recent Blog Posts

[Resolving AutoDiscoveryMethodFactory exceptions in SoapUI 5.3 while using Test Runner](https://www.igorkromin.net/index.php/2018/10/29/resolving-autodiscoverymethodfactory-exceptions-in-soapui-53-while-using-test-runner/)

[How to force SourceTree to abort a stuck rebase](https://www.igorkromin.net/index.php/2018/10/28/how-to-force-sourcetree-to-abort-a-stuck-rebase/)

[Using the always true 1=1 condition to help with SQL statement formatting](https://www.igorkromin.net/index.php/2018/10/25/using-the-always-true-11-condition-to-help-with-sql-statement-formatting/)

[A broken UI bug in macOS Image Capture app - the Cancel button initiating a scan](https://www.igorkromin.net/index.php/2018/10/21/a-broken-ui-bug-in-macos-image-capture-app-the-cancel-button-initiating-a-scan/)

[Failed state during prepare of WS-AT error and Oracle XA WebLogic data source](https://www.igorkromin.net/index.php/2018/10/18/failed-state-during-prepare-of-ws-at-error-and-oracle-xa-weblogic-data-source/)

[Calling Batman - Metal Earth The Dark Knight Bat-Signal Kit](https://www.igorkromin.net/index.php/2018/10/14/calling-batman-metal-earth-the-dark-knight-bat-signal-kit/)

[PLS-00114: identifier too long error and the new Oracle 12.2 long identifiers](https://www.igorkromin.net/index.php/2018/10/11/pls-00114-identifier-too-long-error-and-the-new-oracle-122-long-identifiers/)

[A weird bug in macOS Safari breaks the save dialog after saving a web archive](https://www.igorkromin.net/index.php/2018/10/07/a-weird-bug-in-macos-safari-breaks-the-save-dialog-after-saving-a-web-archive/)

[How to fix PowerMock exception - LinkageError: loader constraint violation](https://www.igorkromin.net/index.php/2018/10/04/how-to-fix-powermock-exception-linkageerror-loader-constraint-violation/)

[Forcing macOS updates to download and install when App Store fails to](https://www.igorkromin.net/index.php/2018/09/30/forcing-macos-updates-to-download-and-install-when-app-store-fails-to/)

#### Blogs and Friends

[Matt Moores Blog](http://mattstats.wordpress.com/)
[Georgi's FlatPress Guide](http://flatpress.georgi.co.uk/)
[Perplexing Permutations](http://chris.de-vries.id.au/)
[The Security Sleuth](http://www.security-sleuth.com/)
[Ilia Rogatchevski](http://iliarogatchevski.com/)

#### Blog Activity

![](../_resources/dc459e5fa7a2527eafc0f5e23308687a.png)
Follow me on...

[![](../_resources/d84ec47183cee850358c9efe1c99c500.png) Facebook](https://facebook.com/igorblog)[![](../_resources/38ee973a1352d8e07e9ef750db4c4f64.png) Twitter](https://twitter.com/ikromin)[![](../_resources/361e8161d4a8c105acb005bef1a8639f.png) Google+](https://plus.google.com/117447228541569254518)

© 2012 - 2018 IgorKromin.net —[Terms & Conditions](https://www.igorkromin.net/termsandconditions)| [Privacy Policy](https://www.igorkromin.net/privacy)

[** RSS Feed](https://feeds.feedburner.com/igorkrominblog)| [Site Map](https://www.igorkromin.net/?sitemap)| [Contact](https://www.igorkromin.net/contact)