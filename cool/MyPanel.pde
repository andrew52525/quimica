import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.swing.event.*;

public class MyPanel extends JPanel implements ActionListener{
  private JButton add, slow, fast;
  private JLabel temp;
  private JComboBox select;

  public MyPanel() {
    setPreferredSize(new Dimension(300, 200));
    add = new JButton("Add atom");
    add.addActionListener(this);
    add.setActionCommand("add");

    String[] s = {"Hydrogen", "Helium", "Lithium", "Boron", "Carbon", "Nitrogen", 
                  "Oxygen", "Fluorine", "Sodium", "Magnesium", "Phosphorous", "Sulfur", "Chlorine"};
    select = new JComboBox(s);
    select.addActionListener(this);
    select.setActionCommand("select");
    
    temp = new JLabel("TEMPERATURE: ");
    
    slow = new JButton("Decrease");
    slow.addActionListener(this);
    slow.setActionCommand("slow");
    
    fast = new JButton("Increase");
    fast.addActionListener(this);
    fast.setActionCommand("fast");

    setLayout(new GridBagLayout());
    GridBagConstraints c = new GridBagConstraints();
    
    c.insets = new Insets(10, 10, 10, 10);    
    c.fill = GridBagConstraints.HORIZONTAL;
    
    // drop down menu
    c.gridx = 0;
    c.gridy = 0;
    add(select, c);
    // add atoms 
    c.gridx = 1;
    add(add, c);
    
    c.insets = new Insets(10, 10, 0, 10);
    // TEMPERATURE
    // label
    c.gridx = 0;
    c.gridy = 1;
    add(temp, c);
    // faster
    c.gridx = 1;
    add(fast, c);
    //slower
    c.gridy = 2;
    add(slow, c);
  }
  
  void actionPerformed(ActionEvent e) {
    String event = e.getActionCommand();
    
    if(event.equals("select")){
      String s = (String)select.getSelectedItem();
      switch(s){
        case "Hydrogen":
          element = 0;
          break;
        case "Helium":
          element = 1;
          break;
        case "Lithium":
          element = 2;
          break;
        case "Boron":
          element = 3;
          break;
        case "Carbon":
          element = 4;
          break;
        case "Nitrogen":
          element = 5;
          break;
        case "Oxygen":
          element = 6;
          break;
        case "Fluorine":
          element = 7;
          break;
        case "Sodium":
          element = 8;
          break;
        case "Magnesium":
          element = 9;
          break;
        case "Phosphorous":
          element = 10;
          break;
        case "Sulfur":
          element = 11;
          break;
        case "Chlorine":
          element = 10;
          break;
      }
    }
    
    if(event.equals("add")){
      added = true;
    }
    
    if(event.equals("slow")){
      slower = true;
    }
    if(event.equals("fast")){
      faster = true;
    }
  }
  
}