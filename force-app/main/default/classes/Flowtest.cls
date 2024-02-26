@isTest
public class Flowtest {
    @isTest
    static void CheckingFlow()
    {
        Event_Manage__c events = New Event_Manage__c ();
        events.Name = 'Test name';
        events.Date_and_Time__c = system.today().addDays(8);
        events.End_Time__c = system.today().addDays(9);
        //Database.SaveResult sr = Database.insert(events,false);
        Database.SaveResult sr = Database.insert(events,false);
        events.Status__c = 'Completed';
        update events;
        system.assertEquals(true,sr.isSuccess(),'Database insert failed');
        //system.assert(false, events);
        List<Feedback__c> feedback = [SELECT Id, name, Event__c from Feedback__c Where Event__c = : events.Id];
        system.assertEquals(true, feedback.size() > 0, 'you got Error');
    }
}