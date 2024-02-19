trigger UserOverlap on Event_Manage__c (before insert) {
    List<Event_Manage__c> events = Trigger.isInsert ? Trigger.new : Trigger.newMap.values();
    Set<Id> organizerIds = new Set<Id>();
    for (Event_Manage__c evt : events) {
        organizerIds.add(evt.Organizer__c);
    }
    Map<Id, List<Event_Manage__c>> organizerToEventsMap = new Map<Id, List<Event_Manage__c>>();
    for (Event_Manage__c evt : [SELECT Id, Organizer__c, Date_and_Time__c, End_Time__c 
                                FROM Event_Manage__c 
                                WHERE Organizer__c IN :organizerIds 
                                AND End_Time__c > :System.now()]) {
        if (!organizerToEventsMap.containsKey(evt.Organizer__c)) {
            organizerToEventsMap.put(evt.Organizer__c, new List<Event_Manage__c>());
        }
        organizerToEventsMap.get(evt.Organizer__c).add(evt);
    }
    for (Event_Manage__c evt : events) {
        if (organizerToEventsMap.containsKey(evt.Organizer__c)) {
            List<Event_Manage__c> organizerEvents = organizerToEventsMap.get(evt.Organizer__c);
            for (Event_Manage__c existingEvt : organizerEvents) {
                if (evt.Date_and_Time__c < existingEvt.End_Time__c &&
                    evt.End_Time__c > existingEvt.Date_and_Time__c) {
                    evt.addError('Organizer is already assigned to another event that has not ended yet: ' + existingEvt.Id);
                    break;
                }
            }
        }
    }
}