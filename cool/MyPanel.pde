import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.swing.event.*;

int type = 0;

public class MyPanel extends JPanel implements ActionListener{
  private JButton add, slow, fast;
  private JLabel temp;
  private JComboBox select;

  public MyPanel() {
    setPreferredSize(new Dimension(300, 200));
    add = new JButton("Add atom");
    add.addActionListener(this);
    add.setActionCommand("add");

    String[] s = {"Hydrogen", "Oxygen"};
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
    if(event.equals("add")){
      //addAtoms(type);
      added = true;
    }
    
    if(event.equals("select")){
      String s = (String)select.getSelectedItem();
      if(s.equals("Hydrogen")){
        type = 0;
      }else{
        type = 1;
      }
    }
    
    if(event.equals("slow")){
      slower = true;
    }
    if(event.equals("fast")){
      faster = true;
    }
  }
  
}