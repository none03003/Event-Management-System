@isTest
public class EventManageValidationTest { 
    @isTest
    static void testDateAndTimeValidation() {
        Event_Manage__c events = new Event_Manage__c();
        events.Name = 'Test Name';
        events.Date_and_Time__c = system.today();
        //system.assert(false, events.Date_and_Time__c);
        Database.saveResult result = Database.insert(events,false);
        system.assertEquals(false, result.isSuccess(), 'System get error' + result.getErrors());
        events.Date_and_Time__c = system.today().addDays(8);
        result = Database.insert(events,false);
        system.assertEquals(true, result.isSuccess(), 'System get error' + result.getErrors());
        /* for(Database.saveResult sr : result){
if (sr.isSuccess()){
system.debug('Sucessfully Insert Event.');
}
else{
System.debug('The error has occurred.');
}

}*/
    }
}