public with sharing class TemporaryUserTriggerHandler {

    private TemporaryUserTriggerHelper helper = new TemporaryUserTriggerHelper();

    /**
     * コンストラクタ
     */
    public TemporaryUserTriggerHandler() {
        
    }

    /**
     * 仮ユーザ登録時にユーザに登録
     */
    public void createUser(List<TemporaryUser__c> temporaryUsers) {
        // ユーザ情報取得
        List<User> users = this.helper.getUsers(temporaryUsers);
        // Add DMLOption
        Database.DMLOptions dlo = new Database.DMLOptions();
        dlo.emailHeader.triggerUserEmail = true;
        // ユーザ情報登録
        List<Database.SaveResult> results = database.insert(users, dlo);
        // 実行結果判定
        this.helper.isSaveResult(results);
    }
}