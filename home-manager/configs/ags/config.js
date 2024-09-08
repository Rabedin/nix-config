// Bluetooth widget
const bluetooth = await Service.import('bluetooth')

const connectedList = Widget.Box({
  setup: self => self.hook(bluetooth, self => {
    self.children = bluetooth.connected_devices
      .map(({ icon_name, name }) => Widget.Box([
        Widget.Icon(icon_name + '-symbolic'),
        Widget.Label(name),
      ]));

    self.visible = bluetooth.connected_devices.length > 0;
  }, 'notify::connected=device'),
})

const indicator = Widget.Icon({
  icon: bluetooth.bind('enabled').as(on =>
    `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
})

// systray Widget
const systemtray = await Service.import('systemtray')

/** @param {import('types/service/systemtray').TrayItem} item */
const SysTrayItem = item => Widget.Button({
  child: Widget.Icon().bind('icon', item, 'icon'),
  tooltipMarkup: item.bind('tooltipMarkup'),
  onPrimaryClick: (_, event) => item.activate(event),
  onSecondaryClick: (_, event) => item.openMenu(event),
});

const sysTray = Widget.Box({
  children: systemtray.bind('items').as(i => i.map(SysTrayItem))
})

// date & time widget
const date = Variable ('', {
  poll: [1000, function() {
    return Date().toString()
  }],
})

// box for the right of the bar
const rightBox = Widget.Box({
  spacing: 8,
  homogeneous: true,
  vertical: false,
  children: [
    connectedList,
    sysTray,
    Widget.Label({ label: date.bind() }),
  ]
})

// main box for the whole bar
const barBox = Widget.CenterBox({
  spacing: 8,
  homogeneous: true,
  vertical: false,
  startWidget: Widget.Label('left widget'),
  centerWidget: Widget.Label('center widget'),
  endWidget: rightBox,
})

// The bar
const Bar = (monitor = 0) => Widget.Window ({
  monitor,
  name: `bar${monitor}`,
  exclusivity: 'exclusive',
  anchor: ['top', 'left', 'right'],
  child: barBox,
})

App.config({
  windows: [
    Bar(0),
  ]
})
