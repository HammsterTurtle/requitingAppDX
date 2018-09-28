public class ImageController
{
    Private Static FINAL String fixedFileName = 'CandidatePhoto.jpg';
    public String formatName{get;set;}
    public Candidate__c candid{get;set;}
    public String imageURL{get;set;}
    public String value{get;set;}
 	public Blob photo{get;set;}
    public Boolean myApexBooleanVariable {get;set;}
  	public Boolean afterMistake {get;set;}
   
    //Contstructor
    public ImageController(ApexPages.StandardController controller){
        candid=(Candidate__c)controller.getRecord();
        myApexBooleanVariable=false;
        afterMistake=false;
    } 
    
    Public void ShowBlockMethod(){
        if (value=='true') {myApexBooleanVariable=true; afterMistake=false;}
        else myApexBooleanVariable=false;
   }
    
    public void SetPhoto(){
        imageURL='/servlet/servlet.FileDownload?file=';
        try{
            ContentVersion cv = new ContentVersion();
            cv.versionData = photo;
            cv.title = 'CandidatePhoto';
            cv.pathOnClient = fixedFileName;
            cv.FirstPublishLocationId = candid.id ;
          	insert cv;
            id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: cv.id].ContentDocumentId;
            id urlPhoto = [select id from contentVersion where ContentDocumentId =:conDoc].id;
            candid.PhotoURL__c=urlPhoto;
            update candid;
        }catch(Exception e){
        system.debug('Exception message'+e);
        }
    }
    
    public PageReference UploadPhoto(){
        if((photo.size() > 1048576) || ((formatName!='image/jpeg') && (formatName!='image/png')))
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.FATAL,'File is too big (more than 1MB) or wrong formated ('+formatName+'). Try another file'));
        	photo = null;
			imageURL = null;
            myApexBooleanVariable=true;
            afterMistake=true;
            PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
            pageRef.setRedirect(false);
            return pageRef;
        }
        else{
            SetPhoto();
            afterMistake=false;
            PageReference pageRef = new PageReference('/'+candid.Id);
            pageRef.setRedirect(true);
            return pageRef;
        }
   }
    
        public void DeletePhoto(){
            if (candid.PhotoURL__c!=null){
                candid.PhotoURL__c=null; }
              try{
                update candid;
                }catch(Exception e) { system.debug('Exception message'+e);}
  }
}