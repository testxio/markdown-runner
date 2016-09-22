# Tests

## Navigation bar

In this chapter we test the navigation bar

### should be able to navigate to all pages

    - go to:
        url: /
    - set:
        menu.AppStore: ''
    - check matches:
        page.title: App Store

### it should allow login

The navigation bar should have a login button

    - go to:
        url: /
    - set:
        menu.AppStore: ''
    - check matches:
        page.title: App Store
