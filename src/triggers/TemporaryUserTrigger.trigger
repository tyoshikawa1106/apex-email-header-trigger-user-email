trigger TemporaryUserTrigger on TemporaryUser__c (after insert) {

    TemporaryUserTriggerHandler handler = new TemporaryUserTriggerHandler();

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // 仮ユーザ作成時にユーザを作成
            handler.createUser(Trigger.new);
        }
    }
}