@isTest
private class TemporaryUserTriggerHandlerTest {

    private static User testAdminUser = TemporaryUserTriggerTester.getTestUser();
    private static final Integer LOOP_MAX_COUNT = 200;

    /**
     * ユーザ情報取得
     */
    static testMethod void createUserTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();

            TemporaryUser__c result = TemporaryUserTriggerTester.createTemporaryUser(true);

            Test.stopTest();

            Integer resultUserCount = [SELECT COUNT() FROM USER WHERE Username =: result.Username__c LIMIT 1000];
            System.assertEquals(resultUserCount, 1);
        }
    }

    /**
     * ユーザ情報取得
     */
    static testMethod void createUserTest2() {
        
        System.runAs(testAdminUser) {

            List<TemporaryUser__c> temporaryUsers = new List<TemporaryUser__c>();

            Test.startTest();
            for (Integer i = 0; i < LOOP_MAX_COUNT; i++) {
                TemporaryUser__c tUser = TemporaryUserTriggerTester.createTemporaryUser(false);
                tUser.Username__c = tUser.Username__c + String.valueOf(i);
                tUser.Alias__c = tUser.Alias__c + String.valueOf(i);
                tUser.CommunityNickname__c = tUser.CommunityNickname__c + String.valueOf(i);
                // Add List
                temporaryUsers.add(tUser);
            }
            insert temporaryUsers;

            Test.stopTest();

            // 検索条件：ユーザ名取得
            Set<String> userNames = new Set<String>();
            for (TemporaryUser__c u : temporaryUsers) {
                userNames.add(u.UserName__c);
            }

            Integer resultUserCount = [SELECT COUNT() FROM USER WHERE Username IN: userNames LIMIT 1000];
            System.assertEquals(resultUserCount, LOOP_MAX_COUNT);
        }
    }
}