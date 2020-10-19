package com.offcn.MyEx;

public class ResultInfo {
    private boolean flag;
    private String messages;

    public ResultInfo(boolean flag, String messages) {
        this.flag = flag;
        this.messages = messages;
    }

    public ResultInfo() {
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getMessages() {
        return messages;
    }

    public void setMessages(String messages) {
        this.messages = messages;
    }
}
