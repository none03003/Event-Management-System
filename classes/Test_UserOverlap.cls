@isTest
private class Test_UserOverlap {
    @isTest
    static void testEventOverlap() {
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
        Speaker__c speaker = new Speaker__c ();
        speaker.Name = 'Test Speaker';
        speaker.Contact_Info__c = 'Test Contact Info';
        insert speaker; 
        Event_Manage__c event1 = new Event_Manage__c();
            event1.Organizer__c = organizer.Id;
            event1.Name = 'Event 1 ' + DateTime.now().getTime();
            event1.Date_and_Time__c = System.now().addDays(8);
            event1.End_Time__c = System.now().addDays(9);
            event1.Location__c ='Test Location';
            event1.Budget__c = 1000; 
            event1.Agenda__c = agenda.Id;
            event1.Speaker__c = speaker.Id;
        insert event1;
       /* event1 = [SELECT Organizer__c from Event_Manage__c WHERE Id = :event1.Id];
        System.assert(false, event1.Organizer__c);*/
        Event_Manage__c event2 = new Event_Manage__c();
            event2.Organizer__c = organizer.Id;
            event2.Name = 'Event 2 ' + DateTime.now().getTime();
            event2.Date_and_Time__c = System.now().addDays(8);
            event2.End_Time__c = System.now().addDays(9);
            event2.Location__c ='Test Location';
            event2.Budget__c = 1000; 
            event2.Agenda__c = agenda.Id;
            event2.Speaker__c = speaker.Id;
        insert event2;
      /*  event2 = [SELECT Organizer__c from Event_Manage__c WHERE Id = :event2.Id];
        System.assert(false, event2.Organizer__c);*/ 
    }
}
        
       /* Test.startTest();
        try {
            insert event2;
            System.assert(false, 'Event insertion should have failed due to overlap');
        } catch (DMLException e) {
            System.assert(e.getMessage().contains('Organizer is already assigned to another event'));
        }
        Test.stopTest();
    }
}*/