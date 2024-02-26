@isTest
private class Test_UserOverlap {
    @isTest
    static void testEventOverlap() {
        Contact contact = new Contact(LastName = 'Test Name');
        insert contact;
        Contact contact1 = new Contact(LastName = 'Test Name1');
        insert contact1;
        Organizer__c organizer = new Organizer__c(Name = 'Test Organizer', Contact__c = contact.Id);
        insert organizer;
        Organizer__c organizer1 = new Organizer__c(Name = 'Test Organizer1', Contact__c = contact1.Id);
        insert organizer1;
        Agenda__c agenda = new Agenda__c(Name = 'Test Agenda', Location__c = 'Test Location');
        insert agenda;
        Speaker__c speaker = new Speaker__c(Name = 'Test Speaker', Email__c = 'test_1@gmail.com', Phone_No__c = '1234567890');
        insert speaker;
        Event_Manage__c event1 = new Event_Manage__c(
            Organizer__c = organizer.Id,
            Name = 'Event 1 ' + DateTime.now().getTime(),
            Date_and_Time__c = System.now().addDays(8),
            End_Time__c = System.now().addDays(9),
            Location__c = 'Test Location',
            Speaker__c = speaker.Id,
            Agenda__c = agenda.Id
        );
        Database.SaveResult result = Database.insert(event1, false);
        System.assertEquals(true,result.isSuccess(), 'Failed to insert event1: ' + result.getErrors());
        
        
        Event_Manage__c event2 = new Event_Manage__c(
            Organizer__c = organizer.Id,
            Name = 'Event 2 ' + DateTime.now().getTime(),
            Date_and_Time__c = System.now().addDays(8),
            End_Time__c = System.now().addDays(9),
            Location__c = 'Test Location',
            Speaker__c = speaker.Id,
            Agenda__c = agenda.Id
        );
        result = Database.insert(event2,false);
        event2.Organizer__c = organizer1.Id;
        result = Database.insert(event2, true);

        System.assertEquals(true,result.isSuccess(), 'Failed to insert non-overlapping event: ' + result.getErrors());
    }
}