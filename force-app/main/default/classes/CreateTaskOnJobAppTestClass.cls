@isTest
private class CreateTaskOnJobAppTestClass
{
    static testMethod void validateCreateTaskOnJobApp()
    {
        List<Position__c> positions = TestDataFactoryForTaskCreationTrigger.createPositions(1);
        List<Candidate__c> candidates = TestDataFactoryForTaskCreationTrigger.createCandids(1);
        List<Job_Application__c> jobApplications = TestDataFactoryForTaskCreationTrigger.createJobApps(2,positions, candidates);
        Job_Application__c jobApplication1 = jobApplications[0];
        jobApplication1.Stage__c = 'Closed - Rejected';
        jobApplication1.Status__c = 'Closed';
        Job_Application__c jobApplication2 = jobApplications[1];
        jobApplication2.Stage__c = 'Offer Extended';
        jobApplication2.Status__c = 'Hold';
        Test.startTest();
        update jobApplications;
        Test.stopTest();
        List<Task> tasksforRejected = new List<Task>([select id from Task where Subject like 'Send Rejection Letter']);
        List<Task> tasksforExtend = new List<Task>([select id from Task where Subject like 'Extend an Offer']);
        System.assertEquals(1, tasksforRejected.size());
     	System.assertEquals(1, tasksforExtend.size());
    }
    static testMethod void validateTaskNOTCreatedOnJobApp()
    {
        List<Position__c> positions = TestDataFactoryForTaskCreationTrigger.createPositions(1);
        List<Candidate__c> candidates = TestDataFactoryForTaskCreationTrigger.createCandids(1);
        List<Job_Application__c> jobApplications = TestDataFactoryForTaskCreationTrigger.createJobApps(1,positions, candidates);
        Job_Application__c jobApplication = jobApplications[0];
        jobApplication.Stage__c = 'Closed - Declined';
        jobApplication.Status__c = 'Closed';
        Test.startTest();
        update jobApplications;
        Test.stopTest();
        List<Task> tasksNotCreated = new List<Task>([select id from Task]);
        System.assertEquals(0, tasksNotCreated.size());
    }
}