@isTest
public class AutomateFeedbackSubmissionTest {

    @isTest     static void testAutomateFeedbackSubmissionFlow() {
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
        Speaker__c speaker = new Speaker__c();
        speaker.Name = 'Test Speaker';
        speaker.Email__c = 'Test Email';
        speaker.Phone
        insert speaker;
        // Create a test Event record
        Event_Manage__c testEvent = new Event_Manage__c(
            Name = 'Test Event',
            Status__c = 'In Progress', // Set the initial status
            Date_and_Time__c = System.now().addDays(8), // Populate required Date_and_Time__c field
            Location__c = 'Test Location', // Populate required Location__c field
            Organizer__c = organizer.Id, // Populate required Organizer__c field
            Budget__c = 1000, // Populate required Budget__c field
            Agenda__c = agenda.Id, // Populate required Agenda__c field
            Speaker__c = speaker.Id, // Populate required Speaker__c field
            End_Time__c = System.now().addDays(9) // Populate required End_Time__c field
        );
        insert testEvent;

        // Create a test Feedback record
        Feedback__c testFeedback = new Feedback__c(
            Event__c = testEvent.Id,
            Name = 'Great event!',
            Rating__c = 5
        );

        // Start the test by updating the Event record to trigger the flow
        testEvent.Status__c = 'Completed'; // Set the status to trigger the flow
        update testEvent;

        // Query the database to check if the Feedback record was created
        List<Feedback__c> createdFeedback = [SELECT Id FROM Feedback__c WHERE Event__c = :testEvent.Id];
        
        // Assert that the Feedback record was created
        System.assertEquals(1, createdFeedback.size(), 'Feedback record should have been created');
    }
}