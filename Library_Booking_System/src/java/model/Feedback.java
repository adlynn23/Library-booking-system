package model;

/**
 * Model class representing a student feedback entry
 */
public class Feedback {
    private int feedbackId;
    private String subject;
    private String message;
    private String date;

    // Default Constructor
    public Feedback() {}

    // Constructor with fields
    public Feedback(String subject, String message) {
        this.subject = subject;
        this.message = message;
    }

    // Getters and Setters (Required for JSP to display data)
    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}