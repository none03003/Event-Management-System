public class EventOverlapHandler {
    
    public static void handleEventOverlap(List<Event_Manage__c> events) {
        
        Set<Id> organizerIds = new Set<Id>();
        for (Event_Manage__c evt : events) {
            organizerIds.add(evt.Organizer__c);
            
        }
        
        Map<Id, List<Event_Manage__c>> organizerToEventsMap = new Map<Id, List<Event_Manage__c>>();
        for (Event_Manage__c evt : [SELECT Id, Organizer__c, Date_and_Time__c, End_Time__c ,Name FROM Event_Manage__c 
                                    WHERE Organizer__c IN :organizerIds AND End_Time__c > :System.now()]) {
                                        
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
                            evt.addError('Organizer is already assigned to another event that has not ended yet: ' + existingEvt.Name );
                            break;
                        }
                }
            }
        }
    }
    
    public static void updateStatus(List<Event_Manage__c> events, Map<Id, Event_Manage__c> newEvent, Map<Id, Event_Manage__c> oldEvent) {
        Set<Id> organizerIds = new Set<Id>();
        for (Event_Manage__c evt : events) {
            organizerIds.add(evt.Organizer__c);
        }
        
        Map<Id, List<Event_Manage__c>> organizerToEventMap = new Map<Id, List<Event_Manage__c>>();
        for (Event_Manage__c evt : [SELECT Id, Organizer__c, Date_and_Time__c, End_Time__c, Organizer__r.Status__c FROM Event_Manage__c 
                                    WHERE Organizer__c IN :organizerIds AND End_Time__c > :System.now()]) {
                                        if (!organizerToEventMap.containsKey(evt.Organizer__c)) {
                                            organizerToEventMap.put(evt.Organizer__c, new List<Event_Manage__c>());
                                        }
                                        organizerToEventMap.get(evt.Organizer__c).add(evt);
                                    }  
        
        for (Event_Manage__c evt : events) {
            if (organizerToEventMap.containsKey(evt.Organizer__c)) {
                List<Event_Manage__c> organizerEvents = organizerToEventMap.get(evt.Organizer__c);
                for (Event_Manage__c existingEvt : organizerEvents){
                    if (evt.Organizer__c != null && evt.End_Time__c > existingEvt.Date_and_Time__c) {
                        if (evt.Organizer__r != null) {
                            evt.Organizer__r.Status__c = 'Unavailable';

                        }
                    } else if (evt.Organizer__c != null && evt.End_Time__c <= System.now()) {
                        if (evt.Organizer__r != null) {
                            evt.Organizer__r.Status__c = 'Available';
                        }
                    }
                }
            }
        }
    }
}