public with sharing class TemporaryUserTriggerTester {

    /**
     * テスト実行ユーザ取得
     */
    public static User getTestUser() {
        return new User(Id = UserInfo.getUserId());
    }

    /**
     * 仮ユーザテストデータ作成
     */
    public static TemporaryUser__c createTemporaryUser(Boolean isInsert) {
        TemporaryUser__c temporaryUser = new TemporaryUser__c(
             LastName__c = 'Yoshikawa'
            ,Alias__c = 'TY'
            ,Email__c = 'testuser@example.com.test'
            ,Username__c = 'testuser@example.com.test'
            ,CommunityNickname__c = 'TY'
        );

        if (isInsert) {
            insert temporaryUser;
        }

        return temporaryUser;
    }
}