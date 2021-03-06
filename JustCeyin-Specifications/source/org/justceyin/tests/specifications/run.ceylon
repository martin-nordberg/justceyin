
import ceylon.file { 
    current
}
import org.justceyin.foundations.files { 
    createDirectoryIfNeeded 
}
import org.justceyin.foundations.io { 
    FileAppender,
    TextWriter,
    TextWriterAppender
}

doc "Run the self tests of module `org.justceyin.specifications`."
void run() {

    // create the output folder if needed
    value logPath = current.childPath( "logs" );
    createDirectoryIfNeeded( logPath );
    
    // set up the output log
    TextWriter log = TextWriterAppender( FileAppender( logPath.childPath("specifications-test.log"), false ) );
    
    try /*( log )*/ {
        log.open();
        
        log.writeLine( "Cey what you mean ..." );
    
        runSpecificationTests( log );
    
        log.writeLine( "All tests completed successfully." );
        print( "All tests completed successfully." );
    }
    finally {
        log.close( null );
    }
}
