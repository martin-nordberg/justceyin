"
 Package of facilities for concurrent task execution. A thin and narrow wrapper around java.util.concurrent.
 
 The central facility of this package is the concept of a `ThreadPool`. Once created, a thread pool offers
 three ways to compute results in its background threads: futures and completion callbacks.
 
 **Futures**
 
 A future wraps the result of an ordinary Ceylon function call such that the function is executed in a 
 background thread and can be retrieved by the foreground thread (or any other thread) at a later time 
 in a blocking manner.
 
 \`\`\`
     // a long-running function to be executed in a background thread
     MyThing myTimeConsumingFunction() {
         // time consuming code ...
         return MyThing(...);
     }
 
     ThreadPool pool = makeThreadPool();
        
     try /*( pool )*/ {
         pool.open();
         
         // launch a time-consuming task in a thread from the pool
         Future<Whole> future = pool.computeAsynchronously( myTimeConsumingFunction );
 
         // do something else for a while ...
        
         // get the future result, waiting for it if needed
         MyThing result = future.get();
        
         // use the result ..
     }
     finally {
         pool.close( null );
     }
 \`\`\`
 
 **Completion Callbacks**
 
 Completion callbacks are cross-thread callbacks whereby the result of a background thread computation is
 passed to a callback function executing in the foreground thread once the foreground thread is ready to 
 receive such callbacks.
 
 \`\`\`
 
     // First task - an ordinary Ceylon function ...
     MyThing myTimeConsumingSingleResultFunction() {
         // time consuming code ...
         return MyThing(...);
     }
 
     // ... converted to callback completion style
     value task1 = computeAndContinue( myTimeConsumingSingleResultFunction );
 
     // Second task - a longer-running background task with multiple callbacks
     void task2( Anything(MyThing) succeed, Anything(Exception) fail ) {
         while ( /* more to do ... */ ) {
             try {
                 MyThing result = ...;
                 succeed( result )
             }
             catch ( Exception e ) {
                 fail(e);
             }
         }
     }
 
     // callbacks
     void success( MyThing result ) {
         // do something useful with result ...
     }
     void failure( Exception e ) {
         // recover from the error ...
     }
        
     ThreadPool pool = makeThreadPool();
        
     try /*( pool )*/ {
         pool.open();
         
         // start up the two tasks
         pool.executeAndContinue<MyThing>( task1, success, failure );
         pool.executeAndContinue<MyThing>( task2, success, failure );
         
         // handle callbacks until both tasks are done
         pool.receiveCompletionCallbacks();
     }
     finally {
         pool.close( null );
     }

 \`\`\`
 
 **Producer/Consumer Queues**
 
 A background task can be set up to produce results that are fed through a thread-safe queue into
 the foreground thread, where they can be retrieved by an ordinary (but one-time use) Iterable.
 The background thread blocks when the queue is full and the foreground thread blocks when the queue
 is empty. Client code looks like it is using an ordinary iterable result, and producer code has
 the look of a typical coroutine using a yield-like callback capability inside an ordinary loop.
 
 \`\`\`
 
     // a background producer task with multiple callbacks
     void producerTask( Anything(MyThing) yield, Anything(Exception) fail ) {
         while ( /* more to do ... */ ) {
             try {
                 MyThing result = ...;
                 yield( result )
             }
             catch ( Exception e ) {
                 fail(e);
             }
         }
     }

     ThreadPool pool = makeThreadPool();
        
     try /*( pool )*/ {
         pool.open();
 
         // start the producer/consumer queue and background task
         {MyThing*} results = pool.produceAndConsume<MyThing>( producerTask );
        
         for ( result in results ) {
             // do stuff with result ...
         }
     }
     finally {
         pool.close( null );
     }

 \`\`\`
 
 The module also provides a handful of higher-order utility functions for converting ordinary functions
 into callback-style tasks, composing functions in sequence, etc.
 
 The source code for org.justceyin.anticipations is maintained in GitHub at [https://github.com/martin-nordberg/justceyin](https://github.com/martin-nordberg/justceyin).
"
by "Martin E. Nordberg III"
shared package org.justceyin.anticipations;
