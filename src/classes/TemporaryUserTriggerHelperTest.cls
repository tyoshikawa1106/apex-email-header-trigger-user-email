@isTest
private class TemporaryUserTriggerHelperTest {

    private static TemporaryUserTriggerHelper helper = new TemporaryUserTriggerHelper();
    private static User testAdminUser = TemporaryUserTriggerTester.getTestUser();

    /**
     * ユーザ情報取得
     */
    static testMethod void getUsersTest1() {
        
        System.runAs(testAdminUser) {

            List<TemporaryUser__c> temporaryUsers = new List<TemporaryUser__c>();

            Test.startTest();

            List<User> results = helper.getUsers(temporaryUsers);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * ユーザ情報取得
     */
    static testMethod void getUsersTest2() {
        
        System.runAs(testAdminUser) {

            TemporaryUser__c temporaryUser = TemporaryUserTriggerTester.createTemporaryUser(false);

            List<TemporaryUser__c> temporaryUsers = new List<TemporaryUser__c>();
            temporaryUsers.add(temporaryUser);

            Test.startTest();

            List<User> results = helper.getUsers(temporaryUsers);
            insert results;

            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 登録結果判定
     */
    static testMethod void isSaveResultTest1() {
        
        System.runAs(testAdminUser) {

            List<Database.SaveResult> saveResult = new List<Database.SaveResult>();

            Test.startTest();

            helper.isSaveResult(saveResult);

            Test.stopTest();
        }
    }

    /**
     * 登録結果判定
     */
    static testMethod void isSaveResultTest2() {
        
        System.runAs(testAdminUser) {

            List<TemporaryUser__c> temporaryUsers = new List<TemporaryUser__c>();
            temporaryUsers.add(TemporaryUserTriggerTester.createTemporaryUser(false));
            temporaryUsers.add(TemporaryUserTriggerTester.createTemporaryUser(false));

            List<Database.SaveResult> saveResult = database.insert(temporaryUsers, false);

            Test.startTest();

            helper.isSaveResult(saveResult);

            Test.stopTest();
        }
    }
}