@isTest
public class Flowtest {
List<Event_Manage__c> leads = [SELECT Status__c FROM Event_Manage__c];
}