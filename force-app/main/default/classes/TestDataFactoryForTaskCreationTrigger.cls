public class TestDataFactoryForTaskCreationTrigger
{
    public static Integer positionsListSize;
    public static Integer candidatesListSize;
    public static List<Candidate__c> createCandids( Integer numberOfCandids)
    {
        List<Candidate__c> candidates = new List<Candidate__c>();
        for ( Integer i = 0 ; i < numberOfCandids ; i++ )
            {
                Candidate__c candidate = new Candidate__c( First_Name__c = 'Candidate' + i, City__c = 'NY');
                candidates.add(candidate);
            }
        insert candidates;
        candidatesListSize = numberOfCandids;
        return candidates;
    }
    public static List<Position__c> createPositions( Integer numberOfPositions )
    {
        List<Position__c> positions = new List<Position__c>();
        for ( Integer i = 0 ; i < numberOfPositions ; i++ )
            {
                Position__c position = new Position__c( Name = 'Position' + i);
                positions.add(position);
            }
        insert positions;
        positionsListSize = numberOfPositions;
        return positions;
    }
    public static List<Job_Application__c> createJobApps( Integer numberOfJobApps,List<Position__c> positions, List<Candidate__c> candidates )
    {
        List<Job_Application__c> jobApps = new List<Job_Application__c>();
        positions = createPositions(positionsListSize);
        candidates = createCandids(candidatesListSize);
        for ( Integer i = 0 ; i < numberOfJobApps ; i++ )
            {
                Position__c position = positions[0];
                Candidate__c candidate = candidates[0];
                Job_Application__c jobApp = new Job_Application__c(Stage__c='New',Status__c='Open',Position__c = position.Id, Candidate__c = candidate.id);
                jobApps.add(jobApp);
            }
        insert jobApps;
        return jobApps;
    }
}