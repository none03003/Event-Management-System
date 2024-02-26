trigger EventManageTrigger on Event_Manage__c (before insert, before update) {
    for (Event_Manage__c event : Trigger.new) {
        if ((Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(event.Id).Status__c != 'Draft')) && event.Status__c != 'Completed') {
            event.Status__c = 'Draft';
        }
        if (event.Status__c == 'Draft' && event.End_Time__c <= System.now() && event.Status__c != 'Completed') {
            event.Status__c = 'Completed';
        }
    }
}