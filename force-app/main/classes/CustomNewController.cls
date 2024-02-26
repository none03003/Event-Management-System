public with sharing class CustomNewController {
    public Event_Manage__c newEvent { get; set; }
    public CustomNewController(ApexPages.StandardController controller) {
        newEvent = (Event_Manage__c)controller.getRecord();
    }
    public PageReference save() {
        try {
            insert newEvent;
            return new PageReference('/' + newEvent.Id);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An error occurred while saving the record: ' + e.getMessage()));
            return null;
        }
    }
}