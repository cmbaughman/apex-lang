/* ============================================================
 * This code is part of the 'apex-lang' open source project avaiable at:
 * 
 *      http://code.google.com/p/apex-lang/
 *
 * This code is licensed under the Apache License, Version 2.0.  You may obtain a 
 * copy of the License at:
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * ============================================================
 */
@IsTest
private class StopWatchTest{

    private static testmethod void testStopWatchSimple(){
        StopWatch watch = new StopWatch();
        watch.start();
        watch.stop();
        long timex = watch.getTime();
        System.assertEquals(timex, watch.getTime());
        watch.reset();
        System.assertEquals(0, watch.getTime());
        watch.toStr();
    }
    
    private static testmethod void testStopWatchSimpleGet(){
        StopWatch watch = new StopWatch();
        System.assertEquals(0, watch.getTime());
        watch.start();
        System.assert(watch.getTime() < 2000);
    }
    
    private static testmethod void testStopWatchSplit(){
        StopWatch watch = new StopWatch();
        watch.start();
        watch.split();
        long splitTime = watch.getSplitTime();
        String splitStr = watch.toSplitString();
        watch.unsplit();
        watch.stop();
        long totalTime = watch.getTime();

        System.assert(splitTime < 700);
        System.assert(totalTime < 700);
    }
    
    private static testmethod void testStopWatchSuspend(){
        StopWatch watch = new StopWatch();
        watch.start();
        watch.suspend();
        long suspendTime = watch.getTime();
        watch.resume();
        watch.stop();
        
        System.assert(suspendTime < 700);
    }

    private static testmethod void testLang315() {
        StopWatch watch = new StopWatch();
        watch.start();
        watch.suspend();
        long suspendTime = watch.getTime();
        watch.stop();
        long totalTime = watch.getTime();
        System.assertEquals( suspendTime, totalTime );
    }

    private static testmethod void testBadStates() {
        StopWatch watch = new StopWatch();
        Boolean exceptionCaught = false;
        try {
            watch.stop();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling stop on an unstarted StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.stop();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling stop on an unstarted StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.suspend();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling suspend on an unstarted StopWatch should throw an exception.');
 
        exceptionCaught = false;
        try {
            watch.split();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling split on a non-running StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.unsplit();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling unsplit on an unsplit StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.resume();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling resume on an unsuspended StopWatch should throw an exception. ');

        watch.start();

        exceptionCaught = false;
        try {
            watch.start();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling start on a started StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.unsplit();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling unsplit on an unsplit StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.getSplitTime();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling getSplitTime on an unsplit StopWatch should throw an exception. ');

        exceptionCaught = false;
        try {
            watch.resume();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling resume on an unsuspended StopWatch should throw an exception. ');

        watch.stop();

        exceptionCaught = false;
        try {
            watch.start();
        } catch(IllegalStateException ise) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling start on a stopped StopWatch should throw an exception as it needs to be reset. ');
    }

    private static testmethod void testGetStartTime() {
        long beforeStopWatch = System.currentTimeMillis();
        StopWatch watch = new StopWatch();
        Boolean exceptionCaught = false;
        try {
            watch.getStartTime();
        } catch (IllegalStateException expected) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling getStartTime on an unstarted StopWatch should throw an exception');
        watch.start();
        exceptionCaught = true;
        String msg = null;
        try {
            watch.getStartTime();
            System.assert(watch.getStartTime() >= beforeStopWatch);
            exceptionCaught = false;
        } catch (IllegalStateException ex) {
            msg = ex.getMessage();
        }
        System.assert(!exceptionCaught,'Start time should be available: ' + msg);
        watch.reset();
        exceptionCaught = false;
        try {
            watch.getStartTime();
        } catch (IllegalStateException expected) {
            exceptionCaught = true;
        }
        System.assert(exceptionCaught,'Calling getStartTime on a reset, but unstarted StopWatch should throw an exception');
    }

}