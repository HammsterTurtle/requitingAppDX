@isTest
public class imageControllerTest
	{
        @isTest static void TestUpload()
        {
 				PageReference testPageRef = Page.Photo;
                Test.setCurrentPage(testPageRef);
                StaticResource file = [select id, name, body,ContentType from StaticResource where name = 'TestInputFileRight' limit 1];
              	List<Candidate__c> candidates = TestDataFactoryForTaskCreationTrigger.createCandids(1);
                ApexPages.StandardController stdController = new ApexPages.standardController(candidates[0]);
                ImageController  extension = new ImageController(stdController);
                extension.photo = file.body;
            	extension.formatName='image/jpeg';
                extension.UploadPhoto();
             	extension.ShowBlockMethod();
             	List<ContentVersion> candidatePhoto = [select id, ContentUrl, VersionData from ContentVersion where FirstPublishLocationId = :candidates[0].id and title = 'CandidatePhoto'];                      
                System.assertEquals(1, candidatePhoto.size());                

        }
        @isTest static void SetPhotoTest(){
                PageReference testPageRef = Page.Photo; 
                Test.setCurrentPage(testPageRef);
                StaticResource file = [select id, name, body from StaticResource where name = 'TestInputFileRight' limit 1];
                List<Candidate__c> candidates = TestDataFactoryForTaskCreationTrigger.createCandids(1);
                ApexPages.StandardController stdController = new ApexPages.standardController(candidates[0]);
                ImageController  extension = new ImageController(stdController);
                extension.photo = file.body;
                extension.SetPhoto();
                List<ContentVersion> candidatePhoto = [select id, ContentUrl, VersionData from ContentVersion where FirstPublishLocationId = :candidates[0].id and title = 'CandidatePhoto'];
                System.assertEquals(1, candidatePhoto.size());        
        }
        
        @isTest static void DeletePhotoTest(){
               PageReference testPageRef = Page.Photo;
                Test.setCurrentPage(testPageRef);
                List<Candidate__c> candidates = TestDataFactoryForTaskCreationTrigger.createCandids(1);
				StaticResource file = [select id, name, body,ContentType from StaticResource where name = 'TestInputFileRight' limit 1];
                ApexPages.StandardController stdController = new ApexPages.standardController(candidates[0]);
                ImageController  extension = new ImageController(stdController);
                extension.photo = file.body;
                extension.UploadPhoto();
             	extension.DeletePhoto();
                System.assertEquals(null,candidates[0].PhotoURL__c);
        	}
        
        @isTest static void UploadBigPhotoTest(){
                PageReference testPageRef = Page.Photo;
                Test.setCurrentPage(testPageRef);
                StaticResource file = [select id, name, body from StaticResource where name = 'TestInputFileWrong' limit 1];
              	List<Candidate__c> candidates = TestDataFactoryForTaskCreationTrigger.createCandids(1);
                ApexPages.StandardController stdController = new ApexPages.standardController(candidates[0]);
                ImageController  extension = new ImageController(stdController);
                extension.photo = file.body;
                extension.UploadPhoto();
                
                System.assertEquals(extension.photo,null);
                System.assertEquals(null,extension.imageURL);
                System.assertEquals(extension.myApexBooleanVariable,true);
                System.assertEquals(extension.afterMistake,true);
                System.assert(ApexPages.getMessages().size() == 1);
				System.assert(ApexPages.getMessages().get(0).getDetail()== 'File is too big (more than 1MB) or wrong formated ('+extension.formatName+'). Try another file');
                System.assert(ApexPages.getMessages().get(0).getSeverity()== ApexPages.Severity.FATAL);
            }
	}