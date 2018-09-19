@isTest
public class AssignPositionToQueueTestClass
{
    static testMethod void validateAssignPositionToQueue()
    {
        Test.startTest();
        List<Position__c> posits = TestDataFactoryForTaskCreationTrigger.createPositions(1);
        id queueId = [Select Id from Group WHERE Type LIKE 'Queue' AND Name LIKE 'Unclaimed Positions Queue' LIMIT 1].Id;
        Test.stopTest();
        List<Position__c> positsNew = [SELECT Id, OwnerId FROM Position__c Where OwnerId=:queueId];
        System.assertEquals(1,positsNew.size());
    }
}