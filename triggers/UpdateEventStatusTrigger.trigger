trigger UpdateEventStatusTrigger on Event_Manage__c (before update) {
    Datetime now = Datetime.now();
    for (Event_Manage__c eventManage : Trigger.new) {
        if (eventManage.End_Time__c != null && eventManage.End_Time__c <= now) {
            eventManage.Status__c = 'Completed';
        }
    }
}