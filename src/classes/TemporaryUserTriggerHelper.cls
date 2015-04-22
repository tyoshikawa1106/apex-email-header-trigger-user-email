public with sharing class TemporaryUserTriggerHelper {

    /**
     * コンストラクタ
     */
    public TemporaryUserTriggerHelper() {
        
    }

    /**
     * ユーザ情報取得
     */
    public List<User> getUsers(List<TemporaryUser__c> temporaryUsers) {
        
        List<User> users = new List<User>();
        for (TemporaryUser__c tUser : temporaryUsers) {
            User user = new User(
                 LastName = tUser.LastName__c
                ,Alias = tUser.Alias__c
                ,Email = tUser.Email__c
                ,Username = tUser.Username__c
                ,CommunityNickname = tUser.CommunityNickname__c
                ,EmailEncodingKey = 'ISO-2022-JP'
                ,TimeZoneSidKey = 'Asia/Tokyo'
                ,LocaleSidKey = 'ja_JP'
                ,LanguageLocaleKey = 'ja'
                ,ProfileId = UserInfo.getProfileId()
            );

            // Add List
            users.add(user);
        }

        return users;
    }

    /**
     * 登録結果判定
     */
    public void isSaveResult(List<Database.SaveResult> results) {
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
}