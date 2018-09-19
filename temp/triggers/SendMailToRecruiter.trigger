trigger SendMailToRecruiter on Position__c (after insert) 
{
	HelperForSendingEmailTrigger helperForSendEmailTrigger = new HelperForSendingEmailTrigger();
    helperForSendEmailTrigger.sendMail(Trigger.New);
}