
"Class providing a mechanism for retrieving values computed asynchronously by a background thread."
by "Martin E. Nordberg III"
shared interface Future<T> {
    
    "Cancels the computation of this future"
    shared formal void cancel( 
        "Whether the task computing this future may be interrupted if currently running."
        Boolean mayInterruptIfRunning = false
    );
    
    "Whether this future was canceled."
    shared formal Boolean canceled;
    
    "Whether the task producing this future value is done."
    shared formal Boolean done;

    "Returns the underlying value of this future."
    shared formal T get(
        "The maximum length of time to wait for the result in milliseconds. 
         Wait indefinitely if not provided."
        Integer? maxWaitTimeMs = null 
    );
    
}