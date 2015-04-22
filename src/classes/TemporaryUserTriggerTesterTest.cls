@isTest
private class TemporaryUserTriggerTesterTest {

    private static User testAdminUser = TemporaryUserTriggerTester.getTestUser();

    /**
     * テスト実行ユーザ取得
     */
    static testMethod void getTestUserTest() {
        
        System.runAs(testAdminUser) {

            Test.startTest();

            User result = TemporaryUserTriggerTester.getTestUser();

            Test.stopTest();

            System.assertEquals(result.Id, UserInfo.getUserId());
        }
    }

    /**
     * 仮ユーザテストデータ作成
     */
    static testMethod void createTemporaryUserTest() {
        
        System.runAs(testAdminUser) {

            Test.startTest();

            // Not Insert
            TemporaryUser__c result = TemporaryUserTriggerTester.createTemporaryUser(false);
            System.assertEquals(String.isEmpty(result.Id), true);

            // Insert
            result = TemporaryUserTriggerTester.createTemporaryUser(true);
            System.assertEquals(String.isNotEmpty(result.Id), true);

            Test.stopTest();
        }
    }
}