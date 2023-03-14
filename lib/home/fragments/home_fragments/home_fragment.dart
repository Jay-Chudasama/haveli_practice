import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text(
                  "Naranpura, Ahmeda...",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "01:12:34",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.alarm)
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.yellowAccent.shade100,
              ),
              child: Center(
                child: Text(
                  "Hurry Up! Order window is OPEN",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                shape: BoxShape.rectangle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5R9_LJrqU1gs9li_WMJGChDmQQsWE408CGw&usqp=CAU",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Lunch",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                    height: 160,
                    width: 120,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          Text(
                            "Rice",
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                //todo
                              },
                              child: Text("Add +"))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                Container(
                    height: 160,
                    width: 120,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          Text(
                            "Rice",
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                //todo
                              },
                              child: Text("Add +"))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                Container(
                    height: 160,
                    width: 120,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          Text(
                            "Rice",
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                //todo
                              },
                              child: Text("Add +"))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 160,
                  width: 120,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        Text(
                          "Rice",
                          style: TextStyle(fontSize: 15),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            //todo
                          },
                          child: Text("Add +"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(),
            Text(
              "Extras",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                    height: 160,
                    width: 120,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          Text(
                            "Rice",
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                //todo
                              },
                              child: Text("Add +"))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                Container(
                    height: 160,
                    width: 120,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          Text(
                            "Rice",
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                //todo
                              },
                              child: Text("Add +"))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                Container(
                    height: 160,
                    width: 120,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          Text(
                            "Rice",
                            style: TextStyle(fontSize: 15),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                //todo
                              },
                              child: Text("Add +"))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 160,
                  width: 120,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        Text(
                          "Rice",
                          style: TextStyle(fontSize: 15),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            //todo
                          },
                          child: Text("Add +"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
