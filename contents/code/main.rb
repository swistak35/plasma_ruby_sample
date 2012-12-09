require 'plasma_applet'

module HelloRuby
  class Main < PlasmaScripting::Applet
    slots 'updateTimer()'
    
    def initialize parent
      super parent
    end
 
    def init
      self.has_configuration_interface = false
      resize 140, 35
      #self.aspect_ratio_mode = Plasma::Square
      
      #mod = Plasma
      #puts mod.constants.collect{|c| mod.const_get(c)}.select{|c| c.class == Class}
      
      @licznik = Qt::Timer.new(self)
      @licznik.start(1000)
      #connect(timer, SIGNAL(timeout()), this, SLOT(showTime()));
      Qt::Object.connect(@licznik, SIGNAL('timeout()'), self, SLOT('updateTimer()'))
      
      initUI
      
      
    end
    
    def initUI
      font = Qt::Font.new
      font.pointSize = 48
      layout = Qt::GraphicsLinearLayout.new Qt::Horizontal, self
      @temp_lcd = Plasma::Label.new self
      @temp_lcd.text = "Loading..."
      @temp_lcd.font = font
      layout.add_item @temp_lcd
      self.layout = layout
      updateInterface
    end
    
    def updateInterface
      output = %x[digitemp -qao "%.2C"]
      #output = "32.49"
      @temp_lcd.text = "#{output} C"
    end
    
    def updateTimer
      updateInterface
    end
  end
end
