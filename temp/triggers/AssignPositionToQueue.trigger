trigger AssignPositionToQueue on Position__c (after insert)
{
    HelperForAssignPositionToQueueTrigger helperForUpdatePositionOwner = new HelperForAssignPositionToQueueTrigger();
    helperForUpdatePositionOwner.assignPositionToQueue(Trigger.New);
}