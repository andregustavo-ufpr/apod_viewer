class BottomNavigationBar extends StatelessWidget{
    const BottomNavigationBar({
        this.pageIndex,
        super.key
    });

    final int pageIndex = 0;

    void _redirect(BuildContext context, String label){
        switch (label){
            case 0:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => Home()
                    )
                );
                return;
            case 1:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => Home()
                    )
                );
                return;
            case 2:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => Home()
                    )
                );
                return;
            default:
                return;

        }
    }

    Widget build(BuildContext context){
        return BottomNavigationBar(
            backgroundColor: const Color(0xFFFFFFFF),
            currentIndex: pageIndex,
            items: [
                BottomNavigationBarItem(
                    activeIcon: Image.asset('${icons[0]}_activated.png'),
                    icon: Image.asset('${icons[0]}_inactive.png'),
                    label: 'Home'),
                BottomNavigationBarItem(
                    activeIcon: Image.asset('${icons[1]}_activated.png'),
                    icon: Image.asset('${icons[1]}_inactive.png'),
                    label: 'Shop'),
                BottomNavigationBarItem(
                    activeIcon: Image.asset('${icons[2]}_activated.png'),
                    icon: Image.asset('${icons[2]}_inactive.png'),
                    label: 'Bag'),
            ],
            onTap: (int index) {
                if (index != pageIndex) {
                    _redirect(context, index)
                }
            },
            selectedLabelStyle: const TextStyle(color: Color(0xFFDB3022)),
            type: BottomNavigationBarType.fixed,
        );
    }
}