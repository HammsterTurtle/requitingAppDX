trigger CreateTaskOnJobApp on Job_Application__c (after update)
{
    List<Task> newTaskList = new List<Task>();
    string taskPriority='Normal';
    string taskStatus='Not Started';
    for (Job_Application__c jobApp : Trigger.new) 
        {
            Job_Application__c oldJobApp = Trigger.oldMap.get(jobApp.ID);
            if (jobApp.Stage__c != oldJobApp.Stage__c)
                {
                    if (jobApp.Stage__c == 'Closed - Rejected')
                        {
                            Task newRejectedTask=new Task(Priority=taskPriority,Status=taskStatus);
                            newRejectedTask.Subject='Send Rejection Letter';
                            newRejectedTask.OwnerId=jobApp.CreatedById;
                            newTaskList.add(newRejectedTask);
                        }
                    if (jobApp.Stage__c == 'Offer Extended')
                        {
                            Task newExtendTask=new Task(Priority=taskPriority,Status=taskStatus);
                            newExtendTask.Subject='Extend an Offer';
                            newExtendTask.OwnerId=jobApp.CreatedById;
                            newTaskList.add(newExtendTask);
                        }
                }
        }
     try
        {
            insert newTaskList;
        } catch (system.Dmlexception e)
        {
            system.debug(e);
        }
}