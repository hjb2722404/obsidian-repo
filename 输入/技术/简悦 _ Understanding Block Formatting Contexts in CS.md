简悦 | Understanding Block Formatting Contexts in CSS — SitePoint

# Understanding Block Formatting Contexts in CSS — SitePoint

   Understanding Block Formatting Contexts in CSS — SitePoint

A [Block Formatting Context](http://www.w3.org/TR/CSS21/visuren.html#block-formatting) is part of the visual CSS rendering of a web page in which block boxes are laid out. The [positioning scheme](http://www.w3.org/TR/CSS2/visuren.html#positioning-scheme) to which it belongs is [normal flow](http://www.w3.org/TR/CSS21/visuren.html#normal-flow). According to [W3C](http://www.w3.org/TR/CSS2/visuren.html#block-formatting):

Floats, absolutely positioned elements, inline-blocks, table-cells, table-captions, and elements with ‘overflow’ other than ‘visible’ (except when that value has been propagated to the viewport) establish new block formatting contexts.

The above quote pretty much sums up how a block formatting context is formed. But lets redefine it in a way that is easier to understand. A block formatting context is an HTML box that satisfies at least one of the following conditions:

- The value of `float` is not `none`
- The value of `position` is neither `static` nor `relative`
- The value of `display` is `table-cell`, `table-caption`, `inline-block`, `flex`, or `inline-flex`
- The value of `overflow` is not `visible`.

## Creating a Block Formatting Context

A block formatting context can be explicitly triggered. So if we want to create a new block formatting context, we just need to add any one of the above mentioned CSS conditions to it.

For example, look at the following HTML:
<div class="container">
Some Content here
</div>

A new block formatting context can be created by adding any one of the necessary CSS conditions like `overflow: scroll`, `overflow: hidden`, `display: flex`, `float: left`, or `display: table` to the container. Though any of the above mentioned conditions can create a block formatting context, there will also be some other effects like:

- `display: table` may create problems in responsiveness
- `overflow: scroll` may show unwanted scrollbars
- `float: left` will push the element to the left, with other elements wrapping around it
- `overflow: hidden` will clip elements that overflow

So whenever we are creating a new block formatting context, we choose the best condition based on our requirements. For uniformity, I have used `overflow: hidden` in all the examples given in this article.

.container {
overflow: hidden;
}
You are free to play with declarations other than `overflow: hidden`.

## Alignment of Boxes in a Block Formatting Context

The W3C spec states:

In a block formatting context, each box’s left outer edge touches the left edge of the containing block (for right-to-left formatting, right edges touch). This is true even in the presence of floats (although a box’s *line boxes* may shrink due to the floats), unless the box establishes a new block formatting context (in which case the box itself [*may* become narrower](http://www.w3.org/TR/CSS21/visuren.html#bfc-next-to-float) due to the floats).

![1435624324alignment.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115522.jpg)

In simpler words, as we can see in the above diagram, all the boxes that belong to a block formatting context are aligned left (for left-to-right formatting) and their left outer edge touches the left edge of the containing block. In the last box we can see that even though there is a floated element (brown) on the left, the other element (green) still touches the left margin of the containing block. The principles about why this happens will be discussed below in the section on text wrapping.

## A Block Formatting Context Causes Collapsing Margins

In normal flow, the boxes are laid vertically one after another starting from the top of the containing block. The vertical distance between two sibling boxes is determined by the individual margins of both siblings, but it’s not the sum of the two margins.

Lets consider an example, in order to understand this.
![1435624303collapse.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115526.jpg)

In the above diagram we consider a block formatting context having been created where the red box (a `div`) contains the two green siblings (`p` elements).

<div class="container">
<p>Sibling 1</p>
<p>Sibling 2</p>
</div>
And the corresponding CSS is:
.container {
background-color: red;
overflow: hidden; }
p {
background-color: lightgreen;
margin: 10px 0;
}

Ideally the margin between the two siblings should have been the sum of the margins of both elements (20px) but it’s actually 10px. This is known as [collapsing margins](http://www.sitepoint.com/web-foundations/collapsing-margins/). In a case where the margins of the siblings are different, then the higher margin will prevail.

See the Pen [OVzrer](http://codepen.io/SitePoint/pen/OVzrer/) by SitePoint ([@SitePoint](http://codepen.io/SitePoint)) on [CodePen](http://codepen.io/).

## Using a Block Formatting Context to Prevent Margin Collapse

This may sound a bit confusing at first since we discussed above that block formatting contexts cause margin collapse. But one thing that we must keep in mind is that vertical margins between adjacent block boxes (siblings) collapse only if they are in the same block formatting context. If they belong to different block formatting contexts then the margins between them won’t collapse. So by creating a new block formatting context we can prevent margin collapse.

Lets add a third sibling in the earlier example, so the HTML becomes:
<div class="container">
<p>Sibling 1</p>
<p>Sibling 2</p>
<p>Sibling 3</p>
</div>
With the corresponding CSS being:
.container {
background-color: red;
overflow: hidden; }
p {
background-color: lightgreen;
margin: 10px 0;
}

The result will be same as above, i.e. there will be a collapse and the three siblings will be separated by a vertical distance of 10px. This happens because all three `p` tags are the part of the same block formatting context.

Now lets modify the third sibling so that it’s part of a new block formatting context. Then the HTML becomes:

<div class="container">
<p>Sibling 1</p>
<p>Sibling 2</p>
<div class="newBFC">
<p>Sibling 3</p>
</div>
</div>
And the CSS:
.container {
background-color: red;
overflow: hidden; }
p {
margin: 10px 0;
background-color: lightgreen;
}
.newBFC {
overflow: hidden; }
Now there will be a difference in the output:
![1435624817preventCollapse.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115531.png)

Since the second and third siblings belong to different formatting contexts, there won’t be any margin collapse between them, as evident in the following demo.

See the Pen [XbVOXp](http://codepen.io/SitePoint/pen/XbVOXp/) by SitePoint ([@SitePoint](http://codepen.io/SitePoint)) on [CodePen](http://codepen.io/).

## Using a Block Formatting Context to Contain Floats

A block formatting context can contain floats. Many times we will encounter a situation where a container has floated elements. In that case the container element has no height and its floated children are outside of the normal flow of the page. We generally use [a clear fix](http://www.sitepoint.com/clearing-floats-overview-different-clearfix-methods/) to solve this problem, with the most popular method being the use of a “cleared” pseudo-element. But we can also accomplish this by defining a block formatting context.

![1435624307containFloat.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115538.jpg)
Lets look at an example:
<div class="container">
<div>Sibling</div>
<div>Sibling</div>
</div>
With the CSS:
.container {
background-color: green;
}
.container div {
float: left;
background-color: lightgreen;
margin: 10px;
}

In the above case the container won’t have any height and it won’t contain the floated children. To solve this problem we establish a new block formatting context inside the container by adding `overflow: hidden`. The modified CSS becomes:

.container {
overflow: hidden; background-color: green;
}
.container div {
float: left;
background-color: lightgreen;
margin: 10px;
}

Now the container will contain the floated siblings and its height will expand to contain its children, with the elements back in the normal flow of the page within this formatting context.

See the Pen [Floats With and Without a Block Formatting Context](http://codepen.io/SitePoint/pen/eNyxZB/) by SitePoint ([@SitePoint](http://codepen.io/SitePoint)) on [CodePen](http://codepen.io/).

## Using Block Formatting Contexts to Prevent Text Wrapping

Sometimes the text around a floated div wraps around it (as in Figure 1 in the image below) but in some cases this is not desirable and we want an appearance like in Figure 2. To solve this, we might use margins, but we can also solve this with a block formatting context.

![1435624320preventWrap.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115542.jpg)

First let us understand why the text wraps. For this we have to understand how the box model works when an element is floated. This is the part I left earlier while discussing the alignment in a block formatting context. Let us understand what is happening in Figure 1 in the diagram below:

![1435624311floatModel.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115547.jpg)
The HTML for the diagram could be assumed as:
<div class="container">
<div class="floated">
Floated div
</div>
<p>

Quae hic ut ab perferendis sit quod architecto, dolor debitis quam rem provident aspernatur tempora

expedita.
</p>
</div>

The whole black area in the above diagram denotes the `p` element. As we can see, the `p` element doesn’t shift but it goes under the floated element. The line boxes of the `p` element (referring to the lines of text) undergo a shift. Hence the line boxes narrow horizontally to make space for the floated element.

As the text increases, it will eventually wrap under the floated element because the line boxes no longer need to shift and hence a condition like Figure 1 appears. This explains how the paragraphs touch the left edge of the containing box even when a floated element is present and how the line boxes narrow to accommodate the floated element.

If we are able to shift the entire `p` element, then this wrapping problem will be solved.

Before going to the solution, let us recall again what the W3C spec says:

In a block formatting context, each box’s left outer edge touches the left edge of the containing block (for right-to-left formatting, right edges touch). This is true even in the presence of floats (although a box’s *line boxes* may shrink due to the floats), unless the box establishes a new block formatting context (in which case the box itself [*may* become narrower](http://www.w3.org/TR/CSS21/visuren.html#bfc-next-to-float) due to the floats).

According to this, if the `p` element establishes a new block formatting context then it will no longer touch the left edge of the container block. This can be achieved by simply adding `overflow: hidden` to the `p` element. This way creating a new block formatting context solves the problem of text wrapping around a floated object.

See the Pen [A Block Formatting Context Preventing Text Wrap](http://codepen.io/SitePoint/pen/xGpMRP/) by SitePoint ([@SitePoint](http://codepen.io/SitePoint)) on [CodePen](http://codepen.io/).

## Using Block Formatting Contexts in Multi-column Layouts

If we are creating a multi-column layout spanning the full width of the container, the last column will sometimes drop to the next line in some browsers. This might happen because the browser is rounding off the column’s width and the total width becomes more than that of the container. If, however, we establish a new block formatting context in a column of the layout, it will always take the remaining space left after the previous columns have filled.

Let’s use an example of a multi-column layout with 3 columns:
Here’s the HTML:
<div class="container">
<div class="column">column 1</div>
<div class="column">column 2</div>
<div class="column">column 3</div>
</div>
And the CSS:
.column {
width: 31.33%;
background-color: green;
float: left;
margin: 0 1%;
}
.column:last-child {
float: none;
overflow: hidden; }
The result is in the CodePen demo:

See the Pen [Using a Block Formatting Context to make a Final Column “fit”](http://codepen.io/SitePoint/pen/gpoqgE/) by SitePoint ([@SitePoint](http://codepen.io/SitePoint)) on [CodePen](http://codepen.io/).

Now even if the width of the container changes slightly, the layout will not break. Of course, this is not necessarily a good option for multi-column layouts, but it is one way to prevent the problem of the final column dropping. Flexbox would likely be a better solution in a case like this, but this should serve to illustrate how elements behave under these circumstances.

## Conclusion

I hope this post has shown you the relevance of block formatting contexts and how they affect the visual positioning of elements on a page. The examples showing their use in practical cases should make them a little more clear.

If you have anything to add, please let us know in the comments. And be sure to review the W3C’s [more detailed discussion of the topic](http://www.w3.org/TR/CSS21/visuren.html#block-formatting) if you want to go deeper.

Ritesh is a web designer and developer having a degree in electrical engineering from IIT Roorkee. He loves learning about the new web technologies and getting familiar with new people. When he is not coding, you can find him playing video games.

     全文完

本文由 [简悦 SimpRead](http://ksria.com/simpread) 转码，用以提升阅读体验，[原文地址](https://www.sitepoint.com/understanding-block-formatting-contexts-in-css/)

Measure
Measure