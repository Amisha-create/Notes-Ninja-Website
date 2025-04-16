import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class NotesNinja {
    public static void main(String[] args) {
        new LoginPage();
    }
}

class LoginPage {
    private JFrame frame;
    private JTextField usernameField;
    private JPasswordField passwordField;
    private JButton loginButton, createAccountButton;

    public LoginPage() {
        frame = new JFrame("Notes Ninja - Login/Create Account");
        frame.setSize(500, 600);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new GridBagLayout());

        JPanel panel = new JPanel(new GridLayout(6, 1, 5, 5));

        JLabel userLabel = new JLabel("User Name:");
        usernameField = new JTextField(15);
        JPanel userPanel = new JPanel(new GridLayout(1, 2, 5, 5));

        JLabel passLabel = new JLabel("Password:");
        passwordField = new JPasswordField(15);
        JPanel passPanel = new JPanel(new GridLayout(1, 2, 5, 5));

        loginButton = new JButton("Login");
        createAccountButton = new JButton("Create Account");
        JPanel buttonPanel = new JPanel();

        userPanel.add(userLabel);
        userPanel.add(usernameField);
        passPanel.add(passLabel);
        passPanel.add(passwordField);
        buttonPanel.add(loginButton);
        buttonPanel.add(createAccountButton);

        panel.add(userPanel);
        panel.add(passPanel);
        panel.add(buttonPanel);

        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.weightx = 1.0;
        gbc.weighty = 1.0;
        gbc.anchor = GridBagConstraints.CENTER;
        frame.add(panel, gbc);

        frame.setVisible(true);

        loginButton.addActionListener(e -> loginUser());
        createAccountButton.addActionListener(e -> createAccount());
    }

    private void loginUser() {
        String username = usernameField.getText();
        String password = new String(passwordField.getPassword());

        if (DatabaseHelper.authenticateUser(username, password)) {
            JOptionPane.showMessageDialog(frame, "Login Successful!", "Success", JOptionPane.INFORMATION_MESSAGE);
            frame.dispose();
            new HomePage();
        } else {
            JOptionPane.showMessageDialog(frame, "Invalid username or password.", "Login Failed", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void createAccount() {
        String username = usernameField.getText();
        String password = new String(passwordField.getPassword());

        if (DatabaseHelper.createUser(username, password)) {
            JOptionPane.showMessageDialog(frame, "Account created successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(frame, "Error creating account.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}

class HomePage {
    public HomePage() {
        JFrame homeFrame = new JFrame("Home Page");
        homeFrame.setSize(500, 400);
        homeFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JLabel welcomeLabel = new JLabel("Welcome to Notes Ninja");
        welcomeLabel.setHorizontalAlignment(SwingConstants.CENTER);
        
        JButton openSubjectsButton = new JButton("View Subjects");
        openSubjectsButton.addActionListener(e -> {
            homeFrame.dispose();
            new SubjectPage();
        });

        JPanel panel = new JPanel();
        panel.add(welcomeLabel);
        panel.add(openSubjectsButton);

        homeFrame.add(panel);
        homeFrame.setVisible(true);
    }
}

class SubjectPage {
    public SubjectPage() {
        JFrame subjectFrame = new JFrame("Subjects");
        subjectFrame.setSize(500, 400);
        subjectFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        String[] subjects = {"Math", "Science", "History", "Computer Science"};
        JList<String> subjectList = new JList<>(subjects);
        subjectList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        JButton openNotesButton = new JButton("Open Notes");
        openNotesButton.addActionListener(e -> {
            String selectedSubject = subjectList.getSelectedValue();
            if (selectedSubject != null) {
                subjectFrame.dispose();
                new NotesPage(selectedSubject);
            }
        });

        JPanel panel = new JPanel();
        panel.add(new JScrollPane(subjectList));
        panel.add(openNotesButton);

        subjectFrame.add(panel);
        subjectFrame.setVisible(true);
    }
}

class NotesPage {
    public NotesPage(String subject) {
        JFrame notesFrame = new JFrame(subject + " Notes");
        notesFrame.setSize(500, 400);
        notesFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JTextArea notesArea = new JTextArea(20, 40);
        JButton uploadButton = new JButton("Upload Notes");
        JButton downloadButton = new JButton("Download Notes");
        
        JPanel panel = new JPanel();
        panel.add(new JScrollPane(notesArea));
        panel.add(uploadButton);
        panel.add(downloadButton);

        notesFrame.add(panel);
        notesFrame.setVisible(true);
    }
}

class DatabaseHelper {
    private static final String URL = "jdbc:mysql://localhost:3307/mydb";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static boolean authenticateUser(String username, String password) {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "SELECT * FROM users WHERE Username = ? AND password = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            return rs.next();
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static boolean createUser(String username, String password) {
        if (username.isEmpty() || !username.matches("[a-zA-Z\\s]+") || password.length() < 8) {
            return false;
        }
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "INSERT INTO users (Username, password) VALUES (?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.executeUpdate();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
