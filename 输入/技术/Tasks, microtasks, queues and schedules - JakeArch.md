Tasks, microtasks, queues and schedules - JakeArchibald.com

 Tasks, microtasks, queues and schedules - JakeArchibald.com

# Tasks, microtasks, queues and schedules

  Posted 17 August 2015 - hold onto your butts for this one, it's spec-heavy

When I told my colleague [Matt Gaunt](https://twitter.com/gauntface) I was thinking of writing a piece on microtask queueing and execution within the browser's event loop, he said"I'll be honest with you Jake, I'm not going to read that". Well, I've written it anyway, so we're all going to sit here and enjoy it, ok?

Actually, if video's more your thing, [Philip Roberts](https://twitter.com/philip_roberts) gave a [great talk at JSConf on the event loop](https://www.youtube.com/watch?v=8aGhZQkoFbQ) - microtasks aren't covered, but it's a great introduction to the rest. Anyway, on with the show…

Take this little bit of JavaScript:

console.log('script start');setTimeout(function()  {  console.log('setTimeout');},  0);Promise.resolve().then(function()  {  console.log('promise1');}).then(function()  {  console.log('promise2');});console.log('script end');

In what order should the logs appear?

## Try it

The correct answer: `script start`, `script end`, `promise1`, `promise2`, `setTimeout`, but it's pretty wild out there in terms of browser support.

Microsoft Edge, Firefox 40, iOS Safari and desktop Safari 8.0.8 log `setTimeout` before `promise1` and `promise2` - although it appears to be a race condition. This is really weird, as Firefox 39 and Safari 8.0.7 get it consistently right.

## Why this happens

To understand this you need to know how the event loop handles tasks and microtasks. This can be a lot to get your head around the first time you encounter it. Deep breath…

Each 'thread' gets its own **event loop**, so each web worker gets its own, so it can execute independently, whereas all windows on the same origin share an event loop as they can synchronously communicate. The event loop runs continually, executing any tasks queued. An event loop has multiple task sources which guarantees execution order within that source (specs [such as IndexedDB](http://w3c.github.io/IndexedDB/#database-access-task-source) define their own), but the browser gets to pick which source to take a task from on each turn of the loop. This allows the browser to give preference to performance sensitive tasks such as user-input. Ok ok, stay with me…

**Tasks** are scheduled so the browser can get from its internals into JavaScript/DOM land and ensures these actions happen sequentially. Between tasks, the browser *may* render updates. Getting from a mouse click to an event callback requires scheduling a task, as does parsing HTML, and in the above example, `setTimeout`.

`setTimeout` waits for a given delay then schedules a new task for its callback. This is why `setTimeout` is logged after `script end`, as logging `script end` is part of the first task, and `setTimeout` is logged in a separate task. Right, we're almost through this, but I need you to stay strong for this next bit…

**Microtasks** are usually scheduled for things that should happen straight after the currently executing script, such as reacting to a batch of actions, or to make something async without taking the penalty of a whole new task. The microtask queue is processed after callbacks as long as no other JavaScript is mid-execution, and at the end of each task. Any additional microtasks queued during microtasks are added to the end of the queue and also processed. Microtasks include mutation observer callbacks, and as in the above example, promise callbacks.

Once a promise settles, or if it has already settled, it queues a *microtask* for its reactionary callbacks. This ensures promise callbacks are async even if the promise has already settled. So calling `.then(yey, nay)` against a settled promise immediately queues a microtask. This is why `promise1` and `promise2` are logged after `script end`, as the currently running script must finish before microtasks are handled. `promise1` and `promise2` are logged before `setTimeout`, as microtasks always happen before the next task.

So, step by step:

.Hello

console.log('script start');setTimeout(function()  {  console.log('setTimeout');},  0);Promise.resolve().then(function()  {  console.log('promise1');}).then(function()  {  console.log('promise2');});console.log('script end');

| Tasks | Run script<br>setTimeout callback |
| --- | --- |
| Microtasks | Promise then<br>Promise then |
| JS stack |     |
| Log | script start<br>script end<br>promise1<br>promise2<br>setTimeout |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 5 2' data-evernote-id='855' class='js-evernote-checked'%3e %3cpath d='M2%2c0 L2%2c2 L0%2c1 z' data-evernote-id='856' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M3%2c0 L5%2c1 L3%2c2 z' data-evernote-id='857' class='js-evernote-checked'%3e%3c/path%3e %3cpath class='prev-btn js-evernote-checked' d='M0%2c0 H2.5V2H0z' data-evernote-id='858'%3e%3c/path%3e %3cpath class='next-btn js-evernote-checked' d='M2.5%2c0 H5V2H2.5z' data-evernote-id='859'%3e%3c/path%3e %3c/svg%3e)

Yes that's right, I created an animated step-by-step diagram. How did you spend *your* Saturday? Went out in the *sun* with your *friends*? Well *I didn't*. Um, in case it isn't clear from my amazing UI design, click the arrows above to advance.

### What are some browsers doing differently?

Some browsers log `script start`, `script end`, `setTimeout`, `promise1`, `promise2`. They're running promise callbacks after `setTimeout`. It's likely that they're calling promise callbacks as part of a new task rather than as a microtask.

This is sort-of excusable, as promises come from ECMAScript rather than HTML. ECMAScript has the concept of "jobs" which are similar to microtasks, but the relationship isn't explicit aside from [vague mailing list discussions](https://esdiscuss.org/topic/the-initialization-steps-for-web-browsers#content-16). However, the general consensus is that promises should be part of the microtask queue, and for good reason.

Treating promises as tasks leads to performance problems, as callbacks may be unnecessarily delayed by task-related things such as rendering. It also causes non-determinism due to interaction with other task sources, and can break interactions with other APIs, but more on that later.

Here's [an Edge ticket](https://connect.microsoft.com/IE/feedback/details/1658365) for making promises use microtasks. WebKit nightly is doing the right thing, so I assume Safari will pick up the fix eventually, and it appears to be fixed in Firefox 43.

Really interesting that both Safari and Firefox suffered a regression here that's since been fixed. I wonder if it's just a coincidence.

## How to tell if something uses tasks or microtasks

Testing is one way. See when logs appear relative to promises & `setTimeout`, although you're relying on the implementation to be correct.

The certain way, is to look up the spec. For instance, [step 14 of `setTimeout`](https://html.spec.whatwg.org/multipage/webappapis.html#timer-initialisation-steps) queues a task, whereas [step 5 of queuing a mutation record](https://dom.spec.whatwg.org/#queue-a-mutation-record) queues a microtask.

As mentioned, in ECMAScript land, they call microtasks "jobs". In [step 8.a of `PerformPromiseThen`](http://www.ecma-international.org/ecma-262/6.0/#sec-performpromisethen), `EnqueueJob` is called to queue a microtask.

Now, let's look at a more complicated example. *Cut to a concerned apprentice* "No, they're not ready!". Ignore him, you're ready. Let's do this…

## Level 1 bossfight

Before writing this post I'd have gotten this wrong. Here's a bit of html:
<div  class="outer">  <div  class="inner"></div></div>
Given the following JS, what will be logged if I click `div.inner`?

// Let's get hold of those elementsvar  outer  =  document.querySelector('.outer');var  inner  =  document.querySelector('.inner');// Let's listen for attribute changes on the// outer elementnew  MutationObserver(function()  {  console.log('mutate');}).observe(outer,  {  attributes:  true});// Here's a click listener…function  onClick()  {  console.log('click');  setTimeout(function()  {  console.log('timeout');  },  0);  Promise.resolve().then(function()  {  console.log('promise');  });  outer.setAttribute('data-random',  Math.random());}// …which we'll attach to both elementsinner.addEventListener('click',  onClick);outer.addEventListener('click',  onClick);

Go on, give it a go before peeking at the answer. *Clue:* Logs can happen more than once.

## Test it

Click the inner square to trigger a click event:

Was your guess different? If so, you may still be right. Unfortunately the browsers don't really agree here:

- ![chrome.041e39c7c6f7.png](../_resources/041e39c7c6f7a7f19554dd1586e94e81.png)

    - click

    - promise

    - mutate

    - click

    - promise

    - mutate

    - timeout

    - timeout

- ![firefox.6d8bb8468f8d.png](../_resources/6d8bb8468f8dbb825c075e3e89612a0d.png)

    - click

    - mutate

    - click

    - mutate

    - timeout

    - promise

    - promise

    - timeout

- ![safari.db3455e864d0.png](../_resources/db3455e864d0d508e162683b2f5fa8a0.png)

    - click

    - mutate

    - click

    - mutate

    - promise

    - promise

    - timeout

    - timeout

- ![edge.1b9de1f3baec.png](../_resources/1b9de1f3baecb2150c3efd73031026ce.png)

    - click

    - click

    - mutate

    - timeout

    - promise

    - timeout

    - promise

## Who's right?

Dispatching the 'click' event is a task. Mutation observer and promise callbacks are queued as microtasks. The `setTimeout` callback is queued as a task. So here's how it goes:

.Hello

// Let's get hold of those elementsvar  outer  =  document.querySelector('.outer');var  inner  =  document.querySelector('.inner');// Let's listen for attribute changes on the// outer elementnew  MutationObserver(function()  {  console.log('mutate');}).observe(outer,  {  attributes:  true});// Here's a click listener…function  onClick()  {  console.log('click');  setTimeout(function()  {  console.log('timeout');  },  0);  Promise.resolve().then(function()  {  console.log('promise');  });  outer.setAttribute('data-random',  Math.random());}// …which we'll attach to both elementsinner.addEventListener('click',  onClick);outer.addEventListener('click',  onClick);

| Tasks | Dispatch click<br>setTimeout callback<br>setTimeout callback |
| --- | --- |
| Microtasks | Promise then<br>Mutation observers<br>Promise then<br>Mutation observers |
| JS stack |     |
| Log | click<br>promise<br>mutate<br>click<br>promise<br>mutate<br>timeout<br>timeout |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 5 2' data-evernote-id='878' class='js-evernote-checked'%3e %3cpath d='M2%2c0 L2%2c2 L0%2c1 z' data-evernote-id='879' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M3%2c0 L5%2c1 L3%2c2 z' data-evernote-id='880' class='js-evernote-checked'%3e%3c/path%3e %3cpath class='prev-btn js-evernote-checked' d='M0%2c0 H2.5V2H0z' data-evernote-id='881'%3e%3c/path%3e %3cpath class='next-btn js-evernote-checked' d='M2.5%2c0 H5V2H2.5z' data-evernote-id='882'%3e%3c/path%3e %3c/svg%3e)

So it's Chrome that gets it right. The bit that was'news to me' is that microtasks are processed after callbacks (as long as no other JavaScript is mid-execution), I thought it was limited to end-of-task. This rule comes from the HTML spec for calling a callback:

***

If the [stack of script settings objects](https://html.spec.whatwg.org/multipage/webappapis.html#stack-of-script-settings-objects) is now empty, [perform a microtask checkpoint](https://html.spec.whatwg.org/multipage/webappapis.html#perform-a-microtask-checkpoint)

— [HTML: Cleaning up after a callback](https://html.spec.whatwg.org/multipage/webappapis.html#clean-up-after-running-a-callback) step 3*

…and a microtask checkpoint involves going through the microtask queue, unless we're already processing the microtask queue. Similarly, ECMAScript says this of jobs:

***

Execution of a Job can be initiated only when there is no running execution context and the execution context stack is empty…

— [ECMAScript: Jobs and Job Queues](http://www.ecma-international.org/ecma-262/6.0/#sec-jobs-and-job-queues)*

…although the "can be" becomes "must be" when in an HTML context.

## What did browsers get wrong?

**Firefox** and **Safari** are correctly exhausting the microtask queue between click listeners, as shown by the mutation callbacks, but promises appear to be queued differently. This is sort-of excusable given that the link between jobs & microtasks is vague, but I'd still expect them to execute between listener callbacks. [Firefox ticket](https://bugzilla.mozilla.org/show_bug.cgi?id=1193394). [Safari ticket](https://bugs.webkit.org/show_bug.cgi?id=147933).

With **Edge** we've already seen it queue promises incorrectly, but it also fails to exhaust the microtask queue between click listeners, instead it does so after calling all listeners, which accounts for the single `mutate` log after both `click` logs. [Bug ticket](https://connect.microsoft.com/IE/feedbackdetail/view/1658386/microtasks-queues-should-be-processed-following-event-listeners).

## Level 1 boss's angry older brother

Ohh boy. Using the same example from above, what happens if we execute:
inner.click();

This will start the event dispatching as before, but using script rather than a real interaction.

## Try it

And here's what the browsers say:

- ![chrome.041e39c7c6f7.png](../_resources/041e39c7c6f7a7f19554dd1586e94e81.png)

    - click

    - click

    - promise

    - mutate

    - promise

    - timeout

    - timeout

- ![firefox.6d8bb8468f8d.png](../_resources/6d8bb8468f8dbb825c075e3e89612a0d.png)

    - click

    - click

    - mutate

    - timeout

    - promise

    - promise

    - timeout

- ![safari.db3455e864d0.png](../_resources/db3455e864d0d508e162683b2f5fa8a0.png)

    - click

    - click

    - mutate

    - promise

    - promise

    - timeout

    - timeout

- ![edge.1b9de1f3baec.png](../_resources/1b9de1f3baecb2150c3efd73031026ce.png)

    - click

    - click

    - mutate

    - timeout

    - promise

    - timeout

    - promise

And I swear I keep getting different results from Chrome, I've updated this chart a ton of times thinking I was testing Canary by mistake. If you get different results in Chrome, tell me which version in the comments.

## Why is it different?

Here's how it should happen:

.Hello

// Let's get hold of those elementsvar  outer  =  document.querySelector('.outer');var  inner  =  document.querySelector('.inner');// Let's listen for attribute changes on the// outer elementnew  MutationObserver(function()  {  console.log('mutate');}).observe(outer,  {  attributes:  true});// Here's a click listener…function  onClick()  {  console.log('click');  setTimeout(function()  {  console.log('timeout');  },  0);  Promise.resolve().then(function()  {  console.log('promise');  });  outer.setAttribute('data-random',  Math.random());}// …which we'll attach to both elementsinner.addEventListener('click',  onClick);outer.addEventListener('click',  onClick);inner.click();

| Tasks | Run script<br>setTimeout callback<br>setTimeout callback |
| --- | --- |
| Microtasks | Promise then<br>Mutation observers<br>Promise then |
| JS stack |     |
| Log | click<br>click<br>promise<br>mutate<br>promise<br>timeout<br>timeout |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 5 2' data-evernote-id='897' class='js-evernote-checked'%3e %3cpath d='M2%2c0 L2%2c2 L0%2c1 z' data-evernote-id='898' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M3%2c0 L5%2c1 L3%2c2 z' data-evernote-id='899' class='js-evernote-checked'%3e%3c/path%3e %3cpath class='prev-btn js-evernote-checked' d='M0%2c0 H2.5V2H0z' data-evernote-id='900'%3e%3c/path%3e %3cpath class='next-btn js-evernote-checked' d='M2.5%2c0 H5V2H2.5z' data-evernote-id='901'%3e%3c/path%3e %3c/svg%3e)

So the correct order is: `click`, `click`, `promise`, `mutate`, `promise`, `timeout`, `timeout`, which Chrome seems to get right.

After each listener callback is called…
***

If the [stack of script settings objects](https://html.spec.whatwg.org/multipage/webappapis.html#stack-of-script-settings-objects) is now empty, [perform a microtask checkpoint](https://html.spec.whatwg.org/multipage/webappapis.html#perform-a-microtask-checkpoint)

— [HTML: Cleaning up after a callback](https://html.spec.whatwg.org/multipage/webappapis.html#clean-up-after-running-a-callback) step 3*

Previously, this meant that microtasks ran between listener callbacks, but `.click()` causes the event to dispatch synchronously, so the script that calls `.click()` is still in the stack between callbacks. The above rule ensures microtasks don't interrupt JavaScript that's mid-execution. This means we don't process the microtask queue between listener callbacks, they're processed after both listeners.

## Does any of this matter?

Yeah, it'll bite you in obscure places (ouch). I encountered this while trying to create [a simple wrapper library for IndexedDB that uses promises](https://github.com/jakearchibald/indexeddb-promised/blob/master/lib/idb.js) rather than weird `IDBRequest` objects. It [*almost* makes IDB fun to use](https://github.com/jakearchibald/indexeddb-promised/blob/master/test/idb.js#L36).

When IDB fires a success event, the related [transaction object becomes inactive after dispatching](http://w3c.github.io/IndexedDB/#fire-a-success-event) (step 4). If I create a promise that resolves when this event fires, the callbacks should run before step 4 while the transaction is still active, but that doesn't happen in browsers other than Chrome, rendering the library kinda useless.

You can actually work around this problem in Firefox, because promise polyfills such as [es6-promise](https://github.com/jakearchibald/es6-promise) use mutation observers for callbacks, which correctly use microtasks. Safari seems to suffer from race conditions with that fix, but that could just be their [broken implementation of IDB](http://www.raymondcamden.com/2014/09/25/IndexedDB-on-iOS-8-Broken-Bad). Unfortunately, things consistently fail in IE/Edge, as mutation events aren't handled after callbacks.

Hopefully we'll start to see some interoperability here soon.

## You made it!

In summary:

- Tasks execute in order, and the browser may render between them
- Microtasks execute in order, and are executed:
    - after every callback, as long as no other JavaScript is mid-execution
    - at the end of each task

Hopefully you now know your way around the event loop, or at least have an excuse to go and have a lie down.

Actually, is anyone still reading? Hello? Hello?

Thanks to Anne van Kesteren, Domenic Denicola, Brian Kardell, and Matt Gaunt for proofreading & corrections. Yeah, Matt actually read it in the end, I didn't even need to go full"Clockwork Orange" on him.

共计：35982 个字   全文完本文由 简悦 [SimpRead](http://ksria.com/simpread) 转码，原文地址 https://jakearchibald.com/2015/tasks-microtasks-queues-and-schedules/