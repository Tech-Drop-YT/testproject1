import '../models/story.dart';
import '../models/story_page.dart';

class StoriesData {
  static final List<Story> stories = [
    // Adventure Stories
    Story(
      id: '1',
      title: 'The Magical Forest Adventure',
      description:
          'Join Lily as she discovers a magical forest filled with talking animals and enchanted trees. A journey of friendship and wonder awaits!',
      thumbnail: 'assets/images/stories/magical_forest.jpg',
      coverImage: 'assets/images/stories/magical_forest_cover.jpg',
      category: 'Adventure',
      isPremium: false,
      rating: 4.8,
      ageGroup: 4,
      author: 'Emma Storyteller',
      pages: [
        StoryPage(
          text:
              'Once upon a time, in a small village, there lived a curious girl named Lily. She loved exploring and discovering new things every day.',
          image: 'assets/images/stories/page1.jpg',
        ),
        StoryPage(
          text:
              'One sunny morning, Lily found a hidden path behind her grandmother\'s garden. The path was covered with colorful flowers and sparkled in the sunlight.',
          image: 'assets/images/stories/page2.jpg',
        ),
        StoryPage(
          text:
              'As she walked down the path, she entered a magical forest. The trees whispered secrets, and birds sang the most beautiful songs she had ever heard.',
          image: 'assets/images/stories/page3.jpg',
        ),
        StoryPage(
          text:
              'A friendly rabbit hopped up to her. "Welcome, Lily! We\'ve been waiting for you," said the rabbit with a warm smile.',
          image: 'assets/images/stories/page4.jpg',
        ),
        StoryPage(
          text:
              'Lily spent the whole day making friends with magical creatures. She learned that kindness and courage can open doors to wonderful adventures.',
          image: 'assets/images/stories/page5.jpg',
        ),
      ],
    ),
    Story(
      id: '2',
      title: 'The Lost Treasure of Rainbow Island',
      description:
          'Captain Timmy and his crew of friendly pirates search for the legendary treasure on Rainbow Island. An exciting adventure full of surprises!',
      thumbnail: 'assets/images/stories/rainbow_island.jpg',
      coverImage: 'assets/images/stories/rainbow_island_cover.jpg',
      category: 'Adventure',
      isPremium: true,
      rating: 4.9,
      ageGroup: 5,
      author: 'Jack Seaborne',
      pages: [
        StoryPage(
          text:
              'Captain Timmy loved sailing the seven seas. But he wasn\'t looking for gold or jewels - he was looking for the Rainbow Treasure, a magical gift that could make anyone smile.',
          image: 'assets/images/stories/treasure1.jpg',
        ),
        StoryPage(
          text:
              'According to the ancient map, the treasure was hidden on Rainbow Island, a place where seven colorful rainbows met at the center.',
          image: 'assets/images/stories/treasure2.jpg',
        ),
        StoryPage(
          text:
              'After sailing for days, Timmy and his crew finally spotted the island. It was the most beautiful place they had ever seen, with colors more vibrant than any rainbow.',
          image: 'assets/images/stories/treasure3.jpg',
        ),
        StoryPage(
          text:
              'They followed the rainbow paths and solved clever puzzles left by the island\'s guardians. Each puzzle taught them about friendship, sharing, and helping others.',
          image: 'assets/images/stories/treasure4.jpg',
        ),
        StoryPage(
          text:
              'At the center of the island, they found the treasure chest. Inside wasn\'t gold, but something better - magical rainbow seeds that could grow happiness wherever they were planted!',
          image: 'assets/images/stories/treasure5.jpg',
        ),
      ],
    ),

    // Fairy Tales
    Story(
      id: '3',
      title: 'The Princess and the Dragon',
      description:
          'A brave princess befriends a misunderstood dragon and learns that friendship can change everything. A heartwarming tale of kindness and understanding.',
      thumbnail: 'assets/images/stories/princess_dragon.jpg',
      coverImage: 'assets/images/stories/princess_dragon_cover.jpg',
      category: 'Fairy Tales',
      isPremium: false,
      rating: 4.7,
      ageGroup: 4,
      author: 'Princess Storyteller',
      pages: [
        StoryPage(
          text:
              'In a kingdom far away, there lived a kind princess named Sofia. Unlike other princesses, she loved reading books about dragons and magical creatures.',
          image: 'assets/images/stories/fairy1.jpg',
        ),
        StoryPage(
          text:
              'One day, a dragon appeared near the castle. Everyone was scared, but Princess Sofia noticed the dragon looked sad and lonely, not scary at all.',
          image: 'assets/images/stories/fairy2.jpg',
        ),
        StoryPage(
          text:
              'Instead of running away, Sofia approached the dragon with kindness. "Hello, friend. Why are you so sad?" she asked gently.',
          image: 'assets/images/stories/fairy3.jpg',
        ),
        StoryPage(
          text:
              'The dragon explained that everyone was afraid of him because he looked different, but all he wanted was a friend. Sofia\'s heart melted with compassion.',
          image: 'assets/images/stories/fairy4.jpg',
        ),
        StoryPage(
          text:
              'From that day on, Sofia and the dragon became best friends. The kingdom learned that being different is special, and true friendship sees beyond appearances.',
          image: 'assets/images/stories/fairy5.jpg',
        ),
      ],
    ),
    Story(
      id: '4',
      title: 'The Enchanted Garden',
      description:
          'Three fairy sisters work together to restore a magical garden. A beautiful story about teamwork and the magic of nature.',
      thumbnail: 'assets/images/stories/enchanted_garden.jpg',
      coverImage: 'assets/images/stories/enchanted_garden_cover.jpg',
      category: 'Fairy Tales',
      isPremium: true,
      rating: 4.6,
      ageGroup: 5,
      author: 'Flora Fairywing',
      pages: [
        StoryPage(
          text:
              'Rose, Lily, and Daisy were three fairy sisters who lived in an enchanted garden. Each fairy had a special power to help plants grow.',
          image: 'assets/images/stories/garden1.jpg',
        ),
        StoryPage(
          text:
              'One winter, the garden\'s magic started fading. The flowers lost their colors, and the trees stopped singing. The fairies knew they had to work together.',
          image: 'assets/images/stories/garden2.jpg',
        ),
        StoryPage(
          text:
              'Rose used her power to bring back the red colors, Lily made the blues and purples return, and Daisy brightened all the yellows and whites.',
          image: 'assets/images/stories/garden3.jpg',
        ),
        StoryPage(
          text:
              'Working as a team, they discovered that their combined magic was stronger than ever. Beautiful flowers bloomed in patterns they had never seen before.',
          image: 'assets/images/stories/garden4.jpg',
        ),
        StoryPage(
          text:
              'The enchanted garden became more magical than ever. The fairy sisters learned that together, they could overcome any challenge and create something truly wonderful.',
          image: 'assets/images/stories/garden5.jpg',
        ),
      ],
    ),

    // Bedtime Stories
    Story(
      id: '5',
      title: 'The Sleepy Moon and Stars',
      description:
          'Join the Moon on a gentle journey across the night sky, saying goodnight to all the sleeping children. Perfect for bedtime!',
      thumbnail: 'assets/images/stories/sleepy_moon.jpg',
      coverImage: 'assets/images/stories/sleepy_moon_cover.jpg',
      category: 'Bedtime',
      isPremium: false,
      rating: 4.9,
      ageGroup: 3,
      author: 'Luna Nightsky',
      pages: [
        StoryPage(
          text:
              'High up in the night sky, the gentle Moon begins her journey. She watches over all the children getting ready for bed.',
          image: 'assets/images/stories/moon1.jpg',
        ),
        StoryPage(
          text:
              'The Moon smiles softly as she sees teddy bears being tucked in, bedtime stories being read, and goodnight kisses being shared.',
          image: 'assets/images/stories/moon2.jpg',
        ),
        StoryPage(
          text:
              'The stars twinkle like tiny nightlights, keeping watch while children dream of magical adventures and wonderful places.',
          image: 'assets/images/stories/moon3.jpg',
        ),
        StoryPage(
          text:
              'As the Moon glides across the sky, she whispers, "Sleep tight, little ones. Tomorrow brings new adventures and joyful discoveries."',
          image: 'assets/images/stories/moon4.jpg',
        ),
        StoryPage(
          text:
              'And with the Moon\'s gentle lullaby and the stars\' soft glow, children all around the world drift into peaceful, sweet dreams. Goodnight!',
          image: 'assets/images/stories/moon5.jpg',
        ),
      ],
    ),
    Story(
      id: '6',
      title: 'The Dream Cloud Express',
      description:
          'Ride on fluffy clouds through dreamland, visiting magical places where anything is possible. A soothing bedtime adventure.',
      thumbnail: 'assets/images/stories/dream_cloud.jpg',
      coverImage: 'assets/images/stories/dream_cloud_cover.jpg',
      category: 'Bedtime',
      isPremium: false,
      rating: 4.8,
      ageGroup: 4,
      author: 'Dreamy McSleep',
      pages: [
        StoryPage(
          text:
              'When you close your eyes at night, a special train made of fluffy white clouds arrives at your window. This is the Dream Cloud Express!',
          image: 'assets/images/stories/cloud1.jpg',
        ),
        StoryPage(
          text:
              'The conductor, a friendly owl, welcomes you aboard. The seats are made of soft pillows, and the windows show the most beautiful starry sky.',
          image: 'assets/images/stories/cloud2.jpg',
        ),
        StoryPage(
          text:
              'The train gently floats through dreamland, passing candy mountains, rivers of warm milk and honey, and forests made of soft blankets.',
          image: 'assets/images/stories/cloud3.jpg',
        ),
        StoryPage(
          text:
              'You meet other sleepy children on the train, all sharing their favorite bedtime wishes and dreams. Everyone smiles and feels so cozy and safe.',
          image: 'assets/images/stories/cloud4.jpg',
        ),
        StoryPage(
          text:
              'As the Dream Cloud Express completes its journey, you arrive back in your bed, feeling peaceful and happy. Sweet dreams until tomorrow!',
          image: 'assets/images/stories/cloud5.jpg',
        ),
      ],
    ),

    // Moral Stories
    Story(
      id: '7',
      title: 'The Sharing Tree',
      description:
          'A wise old tree teaches forest animals about the joy of sharing and helping each other. A beautiful lesson in generosity.',
      thumbnail: 'assets/images/stories/sharing_tree.jpg',
      coverImage: 'assets/images/stories/sharing_tree_cover.jpg',
      category: 'Moral',
      isPremium: false,
      rating: 4.7,
      ageGroup: 4,
      author: 'Wise Woods',
      pages: [
        StoryPage(
          text:
              'In the heart of the forest stood a magnificent oak tree. This tree was special because it loved to share everything it had with the forest animals.',
          image: 'assets/images/stories/moral1.jpg',
        ),
        StoryPage(
          text:
              'The tree shared its acorns with the squirrels, its shade with the rabbits on hot days, and its branches as homes for the birds.',
          image: 'assets/images/stories/moral2.jpg',
        ),
        StoryPage(
          text:
              'One day, a selfish fox tried to keep all the acorns for himself. But he soon realized that having everything made him lonely, with no friends to play with.',
          image: 'assets/images/stories/moral3.jpg',
        ),
        StoryPage(
          text:
              'The wise tree explained, "True happiness comes from sharing with others. When we give, we receive love and friendship in return."',
          image: 'assets/images/stories/moral4.jpg',
        ),
        StoryPage(
          text:
              'The fox learned his lesson and started sharing. Soon, he had more friends than ever, and the forest became a happier place for everyone.',
          image: 'assets/images/stories/moral5.jpg',
        ),
      ],
    ),
    Story(
      id: '8',
      title: 'Brave Little Turtle',
      description:
          'A small turtle overcomes his fears and discovers that courage comes in all sizes. An inspiring story about bravery and self-belief.',
      thumbnail: 'assets/images/stories/brave_turtle.jpg',
      coverImage: 'assets/images/stories/brave_turtle_cover.jpg',
      category: 'Moral',
      isPremium: true,
      rating: 4.8,
      ageGroup: 5,
      author: 'Terry Shellback',
      pages: [
        StoryPage(
          text:
              'Tommy was a little turtle who was afraid of many things - the deep water, loud noises, and especially trying new things.',
          image: 'assets/images/stories/turtle1.jpg',
        ),
        StoryPage(
          text:
              'One day, his friends got stuck in a tangled net near the shore. Everyone was too scared to help, except Tommy knew he had to be brave.',
          image: 'assets/images/stories/turtle2.jpg',
        ),
        StoryPage(
          text:
              'Even though his little legs were shaking, Tommy slowly approached the net. He remembered what his grandmother said: "Courage isn\'t about not being afraid; it\'s about doing the right thing even when you are."',
          image: 'assets/images/stories/turtle3.jpg',
        ),
        StoryPage(
          text:
              'Tommy carefully untangled the net, freeing his friends one by one. It took a long time, but he didn\'t give up, not even once.',
          image: 'assets/images/stories/turtle4.jpg',
        ),
        StoryPage(
          text:
              'All the animals cheered for Brave Little Turtle! Tommy learned that being small doesn\'t mean you can\'t be brave, and sometimes the smallest heroes have the biggest hearts.',
          image: 'assets/images/stories/turtle5.jpg',
        ),
      ],
    ),

    // More Stories
    Story(
      id: '9',
      title: 'The Friendly Robots of Tomorrow Town',
      description:
          'In a futuristic town, robots and children learn to work together and build amazing things. A story about cooperation and innovation.',
      thumbnail: 'assets/images/stories/robots.jpg',
      coverImage: 'assets/images/stories/robots_cover.jpg',
      category: 'Adventure',
      isPremium: true,
      rating: 4.9,
      ageGroup: 6,
      author: 'Robo Writer',
      pages: [
        StoryPage(
          text:
              'In Tomorrow Town, children and friendly robots lived together. The robots helped with homework, played games, and even told jokes!',
          image: 'assets/images/stories/robot1.jpg',
        ),
        StoryPage(
          text:
              'One day, the town\'s playground broke down. The mayor announced a contest: whoever could design the best new playground would win a golden trophy.',
          image: 'assets/images/stories/robot2.jpg',
        ),
        StoryPage(
          text:
              'A girl named Maya teamed up with her robot friend, Bolt. Maya had creative ideas, and Bolt had the technical skills to make them real.',
          image: 'assets/images/stories/robot3.jpg',
        ),
        StoryPage(
          text:
              'Together, they designed a playground with slides that felt like flying, swings that could reach the clouds, and a sandbox that changed colors!',
          image: 'assets/images/stories/robot4.jpg',
        ),
        StoryPage(
          text:
              'Maya and Bolt won the contest! They proved that when humans and robots work together, they can create something truly magical and wonderful.',
          image: 'assets/images/stories/robot5.jpg',
        ),
      ],
    ),
    Story(
      id: '10',
      title: 'The Little Star Who Was Scared to Shine',
      description:
          'A shy little star learns to embrace her unique light and discovers that everyone has something special to offer the world.',
      thumbnail: 'assets/images/stories/little_star.jpg',
      coverImage: 'assets/images/stories/little_star_cover.jpg',
      category: 'Bedtime',
      isPremium: false,
      rating: 4.7,
      ageGroup: 3,
      author: 'Stella Nightlight',
      pages: [
        StoryPage(
          text:
              'In the vast night sky, there was a little star named Stella. She was different from other stars - her light sparkled with rainbow colors.',
          image: 'assets/images/stories/star1.jpg',
        ),
        StoryPage(
          text:
              'Stella was shy about her colorful light. She tried to dim herself so she would look like all the other white stars in the sky.',
          image: 'assets/images/stories/star2.jpg',
        ),
        StoryPage(
          text:
              'One night, a little girl on Earth looked up and said, "I wish I could see a rainbow star to make my wish extra special!"',
          image: 'assets/images/stories/star3.jpg',
        ),
        StoryPage(
          text:
              'The Moon gently encouraged Stella: "Your rainbow light is your gift. Someone down there needs to see it. Don\'t hide what makes you special!"',
          image: 'assets/images/stories/star4.jpg',
        ),
        StoryPage(
          text:
              'Stella took a deep breath and let her rainbow light shine brightly. The little girl\'s wish came true, and Stella learned that being different makes the world more beautiful. Good night, brave little star!',
          image: 'assets/images/stories/star5.jpg',
        ),
      ],
    ),
  ];
}
