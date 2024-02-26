trigger UserOverlap on Event_Manage__c (before insert, after insert, after update) {
    if (Trigger.isInsert && Trigger.isBefore) {
        EventOverlapHandler.handleEventOverlap(Trigger.new);
    } else if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        EventOverlapHandler.updateStatus(Trigger.new, Trigger.newMap, Trigger.oldMap);
    }
}