//**************************************************************
//  edited copy-paste from GuiGeene for a second window 
//**************************************************************

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.swing.event.*;

MyPanel controlPanel;

color paper = color(0);

public class MyPanel extends JPanel{
  private JButton add;
  private JComboBox select;
  private JSlider temperature, concentration;

  public MyPanel() {
    setPreferredSize(new Dimension(300, 200));
    add = new JButton("Add atom");
    add.addActionListener(new AddClick());
    
    String[] s = {"Hydrogen", "Carbon", "Oxygen"};
    select = new JComboBox(s);
    select.addActionListener(new Selection());
    
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
}

class AddClick implements ActionListener{
  void actionPerformed(ActionEvent e){
    JButton b = (JButton)e.getSource();
    b.setLabel("clicked");
  }
}

class Selection implements ActionListener{
  void actionPerformed(ActionEvent e){
  }
}
/*
//**************************************************************
//  This gets called when button is clicked
//**************************************************************

class Button1Click implements ActionListener
{
  public void actionPerformed(ActionEvent e)
  {
    JButton b = (JButton)e.getSource();
    b.setLabel("Thanks!");
    timer=millis()+1000;

    println("Click");
    paper = color(random(255), random(255), random(255));
  }
}
*/