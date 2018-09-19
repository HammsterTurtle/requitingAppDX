@isTest
public class SendMailToRecruiterTestClass
{
    static testMethod void sendEmailTest()
    {
    	Test.startTest();
        List<Position__c> positions = TestDataFactoryForTaskCreationTrigger.createPositions(2);
        Integer invocations = Limits.getEmailInvocations();
    	Test.stopTest();
    }
}