public with sharing class CustomNew {
    public Request_For_Event__c newEvent { get; set; }
    public CustomNew(ApexPages.StandardController controller) {
        newEvent = (Request_For_Event__c)controller.getRecord();
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