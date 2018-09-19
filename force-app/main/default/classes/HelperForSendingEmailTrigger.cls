public class HelperForSendingEmailTrigger
{
    public void sendMail(List<Position__c> positions)
    {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage> ();
        List<Profile> userProfile = [select id from Profile where Name LIKE '%Recruiter%']; // Instead of IN and list of values you can use LIKE '%Recruiter%'. In this case, if new profile with Recruiter be added, you won't need to revrite your code.
        List<User> recruiterUsers=[Select id,email from User where ProfileID IN:userProfile];
        List<String> recruiterEmails = new List<String>();
        for (User user : recruiterUsers)
            {
                recruiterEmails.add(user.Email);
            }
        for(Position__c position : positions)
            {
              //  if (position.recordType.Name)
                string mailBody = 'New position: ' + position.Id + ' was opened! In '+ position.Department__c +' department.';
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSubject('New Position '+position.Name);
                mail.setToAddresses(recruiterEmails);
                mail.setHtmlBody(mailBody);
                mails.add(mail);
            }
          Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
          checkResults(results);
    }
    private static Boolean checkResults(Messaging.SendEmailResult[] results)
    {
        Boolean sendResult = true;
        for (Messaging.SendEmailResult result : results)
        {
            if (result.isSuccess())
            {
                System.debug('Email sent successfully');
            }
            else
            {
                sendResult = false;
                System.debug('The following errors occurred: ' + result.getErrors());
            }
        }
        return sendResult;
    }
}