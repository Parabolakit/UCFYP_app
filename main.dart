import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';
import './color.dart';
import './image.dart';
import './text_style.dart';
import './quize_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(HawkerApp());
}

class HawkerApp extends StatelessWidget {
  final ThemeData themeData;

  HawkerApp({Key? key, ThemeData? themeData})
      : themeData = themeData ?? ThemeData(primarySwatch: Colors.blue),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawker App',
      theme: themeData,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hawker App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: SingleChildScrollView( // Add SingleChildScrollView here
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomePageItem(
                  title: 'Hawker Industry',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HawkerIndustryPage()),
                    );
                  },
                ),
                HomePageItem(
                  title: 'Hawker Culture',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HawkerCulturePage()),
                    );
                  },
                ),
                HomePageItem(
                  title: 'Licensed Hawkers',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LicensedHawkersPage()),
                    );
                  },
                ),
                HomePageItem(
                  title: 'Historical picture',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoricalHawkersPage()),
                    );
                  },
                ),
                HomePageItem(
                  title: 'Quiz Game',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizGamePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ThemeDialog(),
          );
        },
        child: Icon(Icons.color_lens),
      ),
    );
  }
}

class HomePageItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HomePageItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}


class HawkerIndustryPage extends StatelessWidget {
  final List<TimelineItem> timelineItems = [
    TimelineItem(
      period: '1940–1960s',
      title: 'Migrant influx from rural China',
      description: 'Satisfy the need of the working classes. \nPopulation Migration from Mainland China to Hong Kong. In order to make a living, hawkers have to meet their employment needs.',
      background: 'The number of hawkers incredibly increasing in this period.',
      imageUrl: 'images/1950.jpg',
      
    ),
    TimelineItem(
      period: '1960–1970s',
      title: 'Increasing numbers',
      description: 'Rising unemployment, Job opportunities were provided. \nRegulatory status: little regulation. \nIncrease in the number of hawkers, the stock market crash led to an increase in unemployment, the number of hawkers increased to 300,000.',
      background: 'The number increased to the peak in this period',
      imageUrl: 'images/1970.jpeg',
    ),
    TimelineItem(
      period: '1970–2010',
      title: 'Regulation',
      description: 'Regulatory status: Strengthened regulation. \nAccelerated urbanisation, decision not to issue licences in the 1970s, \nreducing the number of hawkers to tens of thousands.',
      background: 'Urbanisation, industrialization Background.\n The number start to dropp as doing business required licences.',
      imageUrl: 'images/2010.jpg',
    ),
    TimelineItem(
      period: '2010 – present',
      title: 'Stakeholder Conflicts',
      description: 'Regulatory situation: Low tolerance for unlicensed hawkers\n Hong Kong people awakening of local awareness and desire to preserve hawker culture,\noften resulting in conflicts among stakeholders.',
      background: 'Lunar New Year incidents and protest against Link REIT',
      imageUrl: 'images/2015.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hawker Industry Timeline'),
      ),
      body: ListView.builder(
        itemCount: timelineItems.length,
        itemBuilder: (context, index) {
          final item = timelineItems[index];
          return TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.5, // Center the vertical line
            isFirst: index == 0,
            isLast: index == timelineItems.length - 1,
            beforeLineStyle: LineStyle(
              color: Colors.grey,
              thickness: 2,
            ),
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicator: _buildIndicator(item.period),
              drawGap: true,
            ),
            startChild: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                children: [
                  if (item.imageUrl.isNotEmpty)
                    Image.asset(
                      item.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 8),
                  Text(
                    '${item.period}: ${item.title}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 8),
                  if (item.background.isNotEmpty)
                    Text(
                      item.background,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center, // Center the text
                    )
                  else
                    Text(
                      'Please add background info.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center, // Center the text
                    ),
                ],
              ),
            ),
            endChild: Container(
              constraints: BoxConstraints(
                minHeight: 80,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  item.description,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator(String period) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          period.substring(0, 4),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TimelineItem {
  final String period;
  final String title;
  final String description;
  final String background;
  final String imageUrl;

  TimelineItem({
    required this.period,
    required this.title,
    required this.description,
    required this.background,
    required this.imageUrl,
  });
}


class HawkerCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hawker Culture'),
      ),
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.purple,
            shape: BoxShape.rectangle,
          ),
          child: Center(
            child: Text(
              'Culture',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class LicensedHawkersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Licensed Hawkers Regulation'),
      ),
      body: ListView(
        children: [
          HawkerItem(
            address: 'Basic structure of cooked food stalls',
            goods: 'Cooked food stalls are mainly made of wood and have to be covered with aluminium sheets or tiles and can be moved at any time. (See Figure 1)',
            openingTime: 'Regional Council (1997). Hawker (Regional Council) Bylaw.',
            imageUrl: 'images/cookstructure.jpg',
          ),
          HawkerItem(
            address: 'Different facilities of cooked food stalls',
            goods: 'According to the Governments requirements, cooked food stalls are required to have cupboards for storing food and utensils, and sterilisers for sterilising food utensils. Stalls are also required to have drip boards, wash basins, metal buckets for storing water, sewage bins and portable dustbins with lids. Cooked food stalls are also required to have two wooden benches of limited length for customers to sit on. (See Figure 2)Translated with www.DeepL.com/Translator (free version)',
            openingTime: 'Regional Council (1997). Hawker (Regional Council) Bylaw.',
            imageUrl: 'images/cookequipment.jpg',
          ),
          //           HawkerItem(
          //   address: 'Requirements for Fixed Pitch Commitment',
          //   goods: 'Fixed stalls should be made of wood and have specific colour requirements.',
          //   openingTime: 'Regional Council (1997). Hawker (Regional Council) Bylaw.',
          //   imageUrl: 'here.jpg',
          // ),
          // Add more HawkerItems here...
        ],
      ),
    );
  }
}

class HistoricalHawkersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historical picture'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          HistoricalHawkerItem(
            imageUrl: 'images/trump.jpg',
          ),
          HistoricalHawkerItem(
            imageUrl: 'images/trump.jpg',
          ),
          // Add more HistoricalHawkerItems here...
        ],
      ),
    );
  }
}

class QuizGamePage extends StatelessWidget {
const QuizGamePage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
	var size = MediaQuery.of(context).size;

	return Scaffold(
	body: SafeArea(
		child: Container(
		width: double.infinity,
		height: double.infinity,
		padding: const EdgeInsets.all(12),
		decoration: const BoxDecoration(
			gradient: LinearGradient(
			begin: Alignment.topCenter,
			end: Alignment.bottomCenter,
			colors: [blue, darkBlue],
		)),
		child: Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
			Container(
				decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(50),
				border: Border.all(color: lightgrey, width: 2),
				),
				child: IconButton(
					onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen (homepage)
          },
					icon: const Icon(
					CupertinoIcons.xmark,
					color: Colors.white,
					size: 28,
					)),
			),
			// Image.asset(
			// 	balloon2,
			// ),
			const SizedBox(height: 10),
			normalText(color: lightgrey, size: 18, text: "Welcome to our"),
			headingText(color: Colors.white, size: 32, text: "Quiz App"),
			const SizedBox(height: 20),
			normalText(
				color: lightgrey,
				size: 16,
				text: "Interesting History Quiz"),
			const Spacer(),
			Align(
				alignment: Alignment.center,
				child: GestureDetector(
				onTap: () {
					Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
				},
				child: Container(
					margin: const EdgeInsets.only(bottom: 7),
					alignment: Alignment.center,
					width: size.width - 100,
					padding: const EdgeInsets.all(16),
					decoration: BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.circular(12),
					),
					child: headingText(color: blue, size: 18, text: "Continue"),
				),
				),
			)
			],
		),
		),
	),
	);
}
}



class HawkerItem extends StatelessWidget {
  final String address;
  final String goods;
  final String openingTime;
  final String imageUrl;

  const HawkerItem({
    required this.address,
    required this.goods,
    required this.openingTime,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image(image: AssetImage(imageUrl)),
          ListTile(
            title: Text(address),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Discription: $goods'),
                Text('Source from: $openingTime'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoricalHawkerItem extends StatelessWidget {
  final String imageUrl;

  const HistoricalHawkerItem({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(image: AssetImage(imageUrl)),
    );
  }
}

class ThemeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              _changeTheme(context, Colors.blue);
            },
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            child: Text('Blue Theme'),
          ),
          ElevatedButton(
            onPressed: () {
              _changeTheme(context, Colors.black);
            },
            style: ElevatedButton.styleFrom(primary: Colors.black),
            child: Text('Dark Theme'),
          ),
          ElevatedButton(
            onPressed: () {
              _changeTheme(context, Colors.pink);
            },
            style: ElevatedButton.styleFrom(primary: Colors.pink),
            child: Text('Pink Theme'),
          ),
          ElevatedButton(
            onPressed: () {
              _changeTheme(context, Colors.green);
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: Text('Green Theme'),
          ),
        ],
      ),
    );
  }

  void _changeTheme(BuildContext context, Color color) {
    var themeData = ThemeData(primarySwatch: MaterialColor(color.value, {
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
    }));
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HawkerApp(themeData: themeData)),
      (Route<dynamic> route) => false,
    );
  }
}
