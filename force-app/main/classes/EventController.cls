public with sharing class EventController {
    @AuraEnabled(cacheable=true)
    public static List<Event_Manage__c> getEvents() {
        return [SELECT Id, Name, Date_and_Time__c, Location__c, Status__c, End_Time__c 
                FROM Event_Manage__c ORDER BY Date_and_Time__c LIMIT 20];
    }
}