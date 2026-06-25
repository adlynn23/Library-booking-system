package model;

public class Feedback {
    private int feedbackId;
    private String matric_no;
    private String subject;
    private String message;
    private String date;
    private String status;
    private String adminReply;
    private String priority;
    private String category;
    private String expectedCompletion;

    public Feedback() {}

    public Feedback(String subject, String message) {
        this.subject = subject;
        this.message = message;
    }

    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public String getMatric_no() { return matric_no; }
    public void setMatric_no(String matric_no) { this.matric_no = matric_no; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAdminReply() { return adminReply; }
    public void setAdminReply(String adminReply) { this.adminReply = adminReply; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getExpectedCompletion() { return expectedCompletion; }
    public void setExpectedCompletion(String expectedCompletion) { this.expectedCompletion = expectedCompletion; }
}
