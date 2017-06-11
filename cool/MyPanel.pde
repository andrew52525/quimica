//**************************************************************
//  edited copy-paste from GuiGeene for a second window 
//**************************************************************

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.swing.event.*;

MyPanel controlPanel;
int type = 0;
color paper = color(0);

public class MyPanel extends JPanel implements ActionListener{
  private JButton add;
  private JComboBox select;
  private JSlider temperature, concentration;

  public MyPanel() {
    setPreferredSize(new Dimension(300, 200));
    add = new JButton("Add atom");
    add.addActionListener(this);
    add.setActionCommand("add");

    String[] s = {"Hydrogen", "Oxygen"};
    select = new JComboBox(s);
    select.addActionListener(this);
    select.setActionCommand("select");

    //-Example: add a change listener to this slider:
    //jcomp6.addChangeListener(new HSlider3Change());

    //adjust size and set layout
    //setPreferredSize (new Dimension (412, 179));
    setLayout(new GridBagLayout());
    GridBagConstraints c = new GridBagConstraints();

    c.gridx = 0;
    c.gridy = 0;
    add(select, c);

    c.gridy = 1;
    add(add, c);
  }
  
  void actionPerformed(ActionEvent e) {
    String event = e.getActionCommand();
    if(event.equals("add")){
      addAtoms(type);
    }
    
    if(event.equals("select")){
      String s = (String)select.getSelectedItem();
      if(s.equals("Hydrogen")){
        type = 0;
      }else{
        type = 1;
      }
    }
  }
}
/*
class AddClick implements ActionListener {
  void actionPerformed(ActionEvent e) {
    JButton b = (JButton)e.getSource();
    //b.setLabel("clicked");
    for (int i = 0; i < 5; i++) {
      atoms.add(new Atom(numAtoms));
      numAtoms++;
    }
  }
}

class Selection implements ActionListener {
}
*/