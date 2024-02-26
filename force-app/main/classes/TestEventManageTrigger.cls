@isTest
public class TestEventManageTrigger {
    @isTest
    static void testEventManageTrigger() {
        Contact contact = new Contact();
        contact.LastName = 'Test Name';
        insert contact;
        Organizer__c organizer = new Organizer__c();
        organizer.Name = 'Test Organizer';
        organizer.Contact__c= contact.Id;
        insert organizer;
        Agenda__c agenda = new Agenda__c();
        agenda.Name = 'Test Agenda';
        agenda.Location__c = 'Test Location';
        insert agenda;
        Event_Manage__c event = new Event_Manage__c();
        event.Name = 'Test Event';
        event.Date_and_Time__c = System.today().addDays(8);
        event.End_Time__c = System.today().addDays(9);
        Datetime initialEndTime = event.End_Time__c;
        event.Agenda__c = agenda.Id;
        event.Organizer__c = organizer.Id;
        insert event;
        event = [SELECT Status__c, End_Time__c, Date_and_Time__c FROM Event_Manage__c WHERE Id = :event.Id];
        System.assertEquals('Draft', event.Status__c, 'Status should be set to "Draft" upon insertion.');
        event.End_Time__c = System.today().addDays(-1);
        update event;
        event = [SELECT Status__c, End_Time__c FROM Event_Manage__c WHERE Id = :event.Id];
        //system.assert(false,event.Status__c);
        System.assertEquals('Completed', event.Status__c, 'Status should be set to "Completed" when end time has passed.');
    }
}