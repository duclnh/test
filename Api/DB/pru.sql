CREATE DATABASE [QuestionWarehouse];
GO
USE [QuestionWarehouse]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 5/22/2024 04:37:59 AM ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[questionId] [uniqueidentifier] NOT NULL,
	[question] [nvarchar](max) NOT NULL,
	[optionA] [nvarchar](max) NOT NULL,
	[optionB] [nvarchar](max) NOT NULL,
	[optionC] [nvarchar](max) NULL,
	[optionD] [nvarchar](max) NULL,
	[answer] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Records]    Script Date: 5/22/2024 04:38:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Records](
	[recordId] [uniqueidentifier] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[isCorrect] [BIT] NOT NULL,
	[questionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Records] PRIMARY KEY CLUSTERED 
(
	[recordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/22/2024 04:38:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userId] [uniqueidentifier] NOT NULL,
	[username] [varchar](20) NOT NULL,
	[password] [varchar](20) NOT NULL,
	[money] [int] NOT NULL,
	[positionX] REAL,
	[positionY] REAL,
	[positionZ] REAL,
	[sence] varchar(20),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Items](
	[itemId] [uniqueidentifier] NOT NULL,
	[slotId] INT NOT NULL,
	[itemName] [varchar](MAX) NOT NULL,
	[amount] INT NOT NULL,
	[price] INT NOT NULL,
	[type] [varchar](MAX) NOT NULL,
	[userId] [uniqueidentifier] NOT NULL
CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[itemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Plants](
	[plantId] [uniqueidentifier] NOT NULL,
	[positionX] REAL,
	[positionY] REAL,
	[positionZ] REAL,
	[datetime] DATETIME,
	[currentStage] INT,
	[quantityHarvested] INT,
	[crop] [varchar](MAX),
	[userId] [uniqueidentifier] NOT NULL
CONSTRAINT [PK_Plants] PRIMARY KEY CLUSTERED 
(
	[plantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Animals](
	[animalId] [uniqueidentifier] NOT NULL,
	[positionX] REAL,
	[positionY] REAL,
	[positionZ] REAL,
	[itemName] [varchar](MAX),
	[datetime] DATETIME,
	[currentStage] INT,
	[quantityHarvested] INT,
	[priceHarvested] INT,
	[hungry] BIT,
	[sick] BIT,
	[localScaleX] REAL,
	[localScaleY] REAL,
	[userId] [uniqueidentifier] NOT NULL
CONSTRAINT [PK_Animals] PRIMARY KEY CLUSTERED 
(
	[animalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Plants]  WITH CHECK ADD  CONSTRAINT [FK_Plants_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Animals]  WITH CHECK ADD  CONSTRAINT [FK_Animals_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO

ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Questions] FOREIGN KEY([questionId])
REFERENCES [dbo].[Questions] ([questionId])
GO
ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Questions]
GO
ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Users]
GO

--INSERT DATA--
INSERT INTO [QuestionWarehouse].[dbo].[Questions] ([questionId],[question], [optionA], [optionB], [optionC], [optionD], [answer])
VALUES 
(NEWID(),N'Mạnh vì...', N'Tiền', N'Bạc', N'Gạo', N'Đất', N'C'),
(NEWID(),N'Thức ăn nào sau đây thuộc nhóm thức ăn chứa nhiều bột đường?', N'Thịt gà', N'Cá', N'Gạo', N'Dầu ăn', N'C'),
(NEWID(),N'Ngôi chùa được đúc hoàn toàn bằng đồng tại Việt Nam là?', N'Chùa Một Cột', N'Chùa Thiên Mụ', N'Chùa Đồng', N'Chùa Bái Đính', N'C'),
(NEWID(),N'Đơn vị đo dung lượng bộ nhớ nào lớn nhất?', N'GB', N'MB', N'TB', N'KB', N'C'),
(NEWID(),N'Hội hát quan họ nào được tổ chức từ 11 - 13 tháng Giêng Âm lịch hàng năm?', N'Hội Lim', N'Hội Gióng', N'Hội Xuân Hương', N'Hội Yên Tử', N'A'),
(NEWID(),N'Một chốn... quê.', N'Mình', N'Đôi', N'Đâu', N'Kia', N'B'),
(NEWID(),N'Cây ngay không sợ...', N'Gió to', N'Chết đứng', N'Mưa dầm', N'Sấm chớp', N'B'),
(NEWID(),N'Sat trong tiếng Anh là thứ mấy trong tuần?', N'Thứ hai', N'Thứ sáu', N'Thứ bảy', N'Chủ nhật', N'C'),
(NEWID(),N'Bán buôn bán lẻ là phạm trù của ngành nào?', N'Công nghiệp', N'Nông nghiệp', N'Thương nghiệp', N'Dịch vụ', N'C'),
(NEWID(),N'Trong các số đo dưới đây, số đo nào bằng 25,08 km?', N'250,8m', N'25080m', N'250800m', N'2508m', N'B'),
(NEWID(),N'Hàm số nào không phải là hàm số chẵn?', N'sin(x)', N'cos(x)', N'cos(x) * sin(x)', N'x^2', N'C'),
(NEWID(),N'Người đẹp vì lụa, ... tốt vì phân.', N'Lúa', N'Cây', N'Hoa', N'Quả', N'A'),
(NEWID(),N'Khả năng đặc biệt có thể làm cho người khác bị mê gọi là?', N'Thôi miên', N'Thần giao cách cảm', N'Chiêu hồn', N'Tâm lý học', N'A'),
(NEWID(),N'Miệng đồng ruột thép thẳng băng/Vặn tai miệng nhả nước văng tràn trề là gì?', N'Cái ấm', N'Cái ca', N'Cái vòi nước', N'Cái chậu', N'C'),
(NEWID(),N'Trạng thái được coi là trạng thái thứ tư sau rắn, lỏng, khí là?', N'Plasma', N'Băng', N'Hơi nước', N'Khí quyển', N'A'),
(NEWID(),N'Người ta thường gọi quốc gia nào là đất nước mặt trời mọc?', N'Nhật Bản', N'Trung Quốc', N'Hàn Quốc', N'Việt Nam', N'A'),
(NEWID(),N'Đây là hoạt động người dân bắc bộ làm để ngăn lũ lụt?', N'Đắp đê', N'Đào mương', N'Đào giếng', N'Đắp đất', N'A'),
(NEWID(),N'Nóc nhà Đông Dương là?', N'Đỉnh Phanxipang', N'Đỉnh Everest', N'Đỉnh Fansipan', N'Đỉnh Himalaya', N'A'),
(NEWID(),N'Ngôi đền nào của Ấn Độ là biểu tượng tình yêu vĩnh cửu?', N'Taj Mahal', N'Chùa Vàng', N'Angkor Wat', N'Đền Lumbini', N'A'),
(NEWID(),N'Mưa chẳng qua... gió chẳng qua mùi?', N'Thìn', N'Ngọ', N'Mùi', N'Tý', N'B'),
(NEWID(),N'Vị thần coi giữ đất đai của một khu vực được dân gian gọi là gì?', N'Thổ địa', N'Thổ công', N'Thần đất', N'Thần thổ', N'B'),
(NEWID(),N'Bên trên là ngói, bên dưới là hang là gì?', N'Cái lọ', N'Miệng', N'Cái bình', N'Cái hang', N'B'),
(NEWID(),N'Người Việt Nam đầu tiên bay vào vũ trụ là ai?', N'Phạm Tuân', N'Nguyễn Văn Cừ', N'Trần Quốc Tuấn', N'Lê Hồng Phong', N'A'),
(NEWID(),N'Tác phẩm bắt đầu bằng tiếng trống thu không là?', N'Hai đứa trẻ - Thạch Lam', N'Chí Phèo - Nam Cao', N'Số đỏ - Vũ Trọng Phụng', N'Đời thừa - Nam Cao', N'A'),
(NEWID(),N'Đâu là tên một nguyên tố hóa học?', N'Liti', N'Heli', N'Li ti', N'Cacbon', N'C'),
(NEWID(),N'Giao điểm 3 đường trung trực của tam giác gọi là?', N'Tâm đường tròn nội tiếp', N'Tâm đường tròn ngoại tiếp', N'Trọng tâm', N'Trực tâm', N'B'),
(NEWID(),N'Con có cha như nhà có nóc, con không cha như... đứt đuôi là gì?', N'Cá', N'Con tằm', N'Nòng nọc', N'Con giun', N'C'),
(NEWID(),N'Trống đánh thật khỏe, đuốc lóe thật nhanh, quạt khắp xa gần, nước văng tung tóe là gì?', N'Mưa', N'Sấm chớp', N'Giông bão', N'Lũ lụt', N'B'),
(NEWID(),N'Ngọn núi nào cao nhất Nhật Bản?', N'Phú Sĩ', N'Everest', N'Kilimanjaro', N'Aconcagua', N'A'),
(NEWID(),N'Sau Extremely, nhóm nhạc nào cover lại bài More Than Words?', N'Backstreet Boys', N'Westlife', N'Weblite', N'NSYNC', N'C'),
(NEWID(),N'Trước Washington, thành phố nào là thủ đô của Mỹ?', N'Philadelphia', N'New York', N'Boston', N'Los Angeles', N'A'),
(NEWID(),N'Chị em dâu như bầu...', N'Bạn', N'Hàng xóm', N'Nước lã', N'Rượu bia', N'C'),
(NEWID(),N'Năm 1910, Morgan đã chọn cái gì làm thí nghiệm về di truyền?', N'Ruồi giấm', N'Chuột', N'Bông cải xanh', N'Ngô', N'A'),
(NEWID(),N'Loại vật liệu dùng trong sản xuất thủy tinh là?', N'Cát trắng', N'Đá vôi', N'Đất sét', N'Thạch anh', N'A'),
(NEWID(),N'Cặp từ nào sau đây không phải là cặp từ đối?', N'Vấn - Đáp', N'Vấn - Lai', N'Nói - Làm', N'Đi - Đứng', N'B'),
(NEWID(),N'Ao... nước đọng.', N'Tù', N'Đình', N'Lặng', N'Nguội', N'A'),
(NEWID(),N'Loài động vật nào có 3 tim, 8 chi và máu màu xanh?', N'Bạch tuộc', N'Sứa', N'Cua', N'Tôm hùm', N'A'),
(NEWID(),N'Sông Đồng Nai bắt nguồn từ đâu?', N'Cao nguyên Lâm Viên', N'Cao nguyên Kon Tum', N'Cao nguyên Đắk Lắk', N'Cao nguyên Lang Biang', N'A'),
(NEWID(),N'Liên đoàn bóng đá Úc thuộc liên đoàn bóng đá nào?', N'Châu Á', N'Châu Âu', N'Châu Phi', N'Châu Mỹ', N'A'),
(NEWID(),N'Hành vi nào xâm hại công trình được bộ nghiêm cấm?', N'Phá hoại đường', N'Sửa chữa cầu', N'Xây nhà', N'Trồng cây', N'A'),
(NEWID(),N'Ai là cha đẻ của thuyết tương đối?', N'Anh-Xtanh', N'Newton', N'Galileo', N'Kepler', N'A'),
(NEWID(),N'Không... thì dưa có giòi.', N'Thương', N'Quý', N'Ưa', N'Yêu', N'C'),
(NEWID(),N'Thăng Long Hà Nội 1000 tuổi vào năm nào?', N'2010', N'2000', N'2020', N'2015', N'A'),
(NEWID(),N'Nước lã mà... nên hồ.', N'Gạn', N'Lọc', N'Vã', N'Đổ', N'C'),
(NEWID(),N'Đầu nhẹ, bụng nặng, có hình bán nguyệt trơn tru không thể ngã là con gì?', N'Con lật đật', N'Con lươn', N'Con cá', N'Con vịt', N'A'),
(NEWID(),N'Người dựng nên nước Âu Lạc là ai?', N'Thục Phán', N'An Dương Vương', N'Hùng Vương', N'Ngô Quyền', N'A'),
(NEWID(),N'Tim người gồm bao nhiêu ngăn?', N'4', N'2', N'3', N'5', N'A'),
(NEWID(),N'Chùa Đồng lớn nhất Việt Nam ở đâu?', N'Núi Yên Tử', N'Núi Bà Nà', N'Núi Ba Vì', N'Núi Cấm', N'A'),
(NEWID(),N'Trạng gì quê đất Trung Am, Bạch Vân Cư Sĩ lấy làm hiệu riêng là ai?', N'Nguyễn Bỉnh Khiêm', N'Nguyễn Du', N'Nguyễn Trãi', N'Nguyễn Đình Chiểu', N'A'),
(NEWID(),N'Trên lông dưới lông, ở giữa không lông, phồng lên để ngắm là gì?', N'Con mắt', N'Con cò', N'Con công', N'Con đom đóm', N'A'),
(NEWID(),N'Quạ... thì ráo, sáo... thì mưa.', N'Tắm', N'Bay', N'Hót', N'Đậu', N'A'),
(NEWID(),N'Không ăn... bỏ cho người.', N'Trộm', N'Chực', N'Gắp', N'Lấy', N'C'),
(NEWID(),N'Tên vũ khí của thổ dân Úc có khả năng bay lại về vị trí cũ là gì?', N'Bumerang', N'Giáo', N'Cung tên', N'Chùy', N'A'),
(NEWID(),N'“U nó không được thế!” là kiểu câu gì?', N'Câu cầu khiến', N'Câu cảm thán', N'Câu trần thuật', N'Câu nghi vấn', N'A'),
(NEWID(),N'Phương tiện nào sau đây ít giống với những cái còn lại?', N'Xe đạp', N'Xe máy', N'Ô tô', N'Máy bay', N'D'),
(NEWID(),N'Thượng điền tích thủy, hạ điền...', N'Khan', N'Mất mùa', N'Lụt', N'Chết khô', N'A'),
(NEWID(),N'Sau chiến tranh thế giới 2, phong trào giải phóng dân tộc nổi lên mạnh nhất ở đâu?', N'Châu Á', N'Châu Phi', N'Châu Mỹ', N'Châu Âu', N'B'),
(NEWID(),N'Silic là kim loại hay phi kim?', N'Kim loại', N'Phi kim', N'Á kim', N'Không phải', N'C'),
(NEWID(),N'Công thức hóa học của đá vôi?', N'CaCO3', N'NaCl', N'H2O', N'CO2', N'A'),
(NEWID(),N'Giải thưởng "Cù Nèo Vàng" dành cho nghệ sĩ hài được cơ quan nào trao tặng?', N'Báo tuổi trẻ', N'Báo lao động', N'Báo tuổi trẻ cười', N'Báo nhân dân', N'C'),
(NEWID(),N'Vua nào đặt nhiều niên hiệu nhất lịch sử nước ta?', N'Lý Thái Tổ', N'Trần Nhân Tông', N'Lý Nhân Tông', N'Lê Thánh Tông', N'C'),
(NEWID(),N'Lớp phủ bên ngoài lá có tác dụng hạn chế thoát hơi nước là?', N'Cutin', N'Lignin', N'Cellulose', N'Pectin', N'A'),
(NEWID(),N'Năm 1954, nước ta ký hiệp định nào với Pháp?', N'Hiệp định Giơ ne vơ', N'Hiệp định Pa ri', N'Hiệp định Paris', N'Hiệp định Évian', N'A'),
(NEWID(),N'Huyện Võ Nhai thuộc tỉnh nào nước ta?', N'Lạng Sơn', N'Thái Nguyên', N'Bắc Kạn', N'Quảng Ninh', N'B'),
(NEWID(),N'Biển có nồng độ muối lớn nhất thế giới?', N'Biển Đen', N'Biển Bắc', N'Biển Chết', N'Biển Đỏ', N'C'),
(NEWID(),N'Ngày bầu cử quốc hội khóa 12?', N'20-05-2006', N'20-05-2007', N'20-05-2008', N'20-05-2009', N'B'),
(NEWID(),N'Miền núi có các vành đai thực vật theo độ cao, phong phú nhất nước ta?', N'Dãy Trường Sơn', N'Dãy Hoàng Liên Sơn', N'Dãy Annamite', N'Dãy Con Voi', N'B'),
(NEWID(),N'Câu nói: "Đầu tôi chưa rơi xuống đất, xin bệ hạ đừng lo" là của ai?', N'Nguyễn Trãi', N'Trần Hưng Đạo', N'Trần Thủ Độ', N'Lê Lợi', N'C'),
(NEWID(),N'Quốc kỳ nào giống hệt quốc kỳ Indonexia nhưng ngược chiều?', N'Monaco', N'Ba Lan', N'Áo', N'Bỉ', N'B'),
(NEWID(),N'Kinh thành trà kiệu thuộc tỉnh nào?', N'Đà Nẵng', N'Quảng Nam', N'Quảng Ngãi', N'Bình Định', N'B'),
(NEWID(),N'Ủy ban nhân dân do ai bầu ra?', N'Quốc hội', N'Chính phủ', N'Hội đồng nhân dân', N'Đảng ủy', N'C'),
(NEWID(),N'Nhạc sĩ Sô Panh gắn liền với nhạc cụ nào?', N'Violin', N'Guitar', N'Piano', N'Sáo', N'C'),
(NEWID(),N'Đảng ta xác định nhiệm vụ trọng tâm trong giai đoạn 1930 - 1945 là gì?', N'Cải cách ruộng đất', N'Giải phóng dân tộc', N'Xây dựng kinh tế', N'Cải tổ bộ máy', N'B'),
(NEWID(),N'Lần đầu tiên nước ta dùng bộc phá 1000 kg thuốc nổ đánh giặc là ở đâu?', N'Điện Biên Phủ', N'Hà Nội', N'Quảng Trị', N'Thành cổ Huế', N'A'),
(NEWID(),N'Ở Chùa Bộc, ngoài thờ phật, nhân dân còn thờ vị tướng nào?', N'Vua Quang Trung', N'Trần Hưng Đạo', N'Lê Lợi', N'Nguyễn Huệ', N'A'),
(NEWID(),N'Đất nước nào là quê hương của ông già tuyết?', N'Phần Lan', N'Thụy Điển', N'Na Uy', N'Nga', N'A'),
(NEWID(),N'Phim hoạt hình đầu tiên được công chiếu vào thời gian nào?', N'28-10-1892', N'20-10-1892', N'28-11-1892', N'10-12-1892', N'A'),
(NEWID(),N'Đảo Sip thuộc châu Á hay châu Âu?', N'Châu Á', N'Châu Âu', N'Châu Phi', N'Châu Mỹ', N'A'),
(NEWID(),N'Lục địa nào được phát hiện gần đây nhất?', N'Châu Úc', N'Châu Mỹ', N'Châu Phi', N'Châu Nam Cực', N'A'),
(NEWID(),N'Quốc gia nào nhỏ nhất thế giới về diện tích?', N'Tòa thánh Vatican', N'Monaco', N'Nauru', N'San Marino', N'A'),
(NEWID(),N'Thành phố châu Âu nào được gọi là thành phố vĩnh cửu?', N'Roma', N'Paris', N'London', N'Berlin', N'A'),
(NEWID(),N'Vĩ tuyến 38 chia bán đảo nào làm đôi và cho biết tên của hai quốc gia hình thành?', N'Triều Tiên', N'Balkan', N'Scandinavia', N'Ý', N'A'),
(NEWID(),N'Đảo Korsika thuộc nước nào?', N'Pháp', N'Ý', N'Tây Ban Nha', N'Bồ Đào Nha', N'A'),
(NEWID(),N'Cảng nào lớn nhất Đông Á?', N'Thượng Hải', N'Singapore', N'Tokyo', N'Busan', N'A'),
(NEWID(),N'Hồ nội địa nào sâu nhất thế giới?', N'Baikal', N'Caspian', N'Victoria', N'Tanganyika', N'A'),
(NEWID(),N'Bạn hãy cho biết tên của ba đại dương?', N'Thái Bình Dương, Đại Tây Dương, Ấn Độ Dương', N'Bắc Băng Dương, Thái Bình Dương, Ấn Độ Dương', N'Đại Tây Dương, Thái Bình Dương, Nam Đại Dương', N'Ấn Độ Dương, Nam Đại Dương, Bắc Băng Dương', N'A'),
(NEWID(),N'Đảo St. Helena nằm ở đâu?', N'Giữa Đại Tây Dương', N'Biển Caribê', N'Địa Trung Hải', N'Ấn Độ Dương', N'A'),
(NEWID(),N'Người ta gọi vùng rừng vành đai Siberi là gì?', N'Rừng Taiga', N'Rừng nhiệt đới', N'Rừng mưa', N'Rừng hỗn hợp', N'A'),
(NEWID(),N'Thành phố Venedig của Ý gồm bao nhiêu đảo?', N'118', N'150', N'200', N'80', N'A'),
(NEWID(),N'Năm 79 tr. CN thảm hoạ núi lửa và động đất đã phá huỷ hoàn toàn hai thành phố La mã. Tên hai thành phố ấy là gì?', N'Pompeji và Herculaneum', N'Pompeii và Carthage', N'Herculaneum và Athens', N'Pompeji và Rome', N'A'),
(NEWID(),N'Tại sao người ta gọi dân da đỏ là Indianer?', N'Columbus nghĩ rằng ông đã đến Ấn Độ', N'Họ đến từ Ấn Độ', N'Họ sống gần Ấn Độ', N'Tên gọi do người Tây Ban Nha đặt', N'A'),
(NEWID(),N'Tên của thành phố Köln thời La mã là gì?', N'Colonia Agippina', N'Colonia Germanica', N'Colonia Romana', N'Colonia Augusta', N'A'),
(NEWID(),N'Hãy kể tên 4 nước lớn nhất về diện tích?', N'Nga, Trung Quốc, Canada, Brazil', N'Nga, Mỹ, Trung Quốc, Canada', N'Canada, Trung Quốc, Brazil, Ấn Độ', N'Nga, Brazil, Úc, Ấn Độ', N'A'),
(NEWID(),N'Babylon nằm ở đâu?', N'Bên bờ sông Euphrat phía nam thành phố Bagdad', N'Gần biên giới Iran', N'Phía tây thành phố Baghdad', N'Bên bờ sông Tigris', N'A'),
(NEWID(),N'Chim cánh cụt sống ở đâu?', N'Châu Nam Cực', N'Châu Phi', N'Châu Úc', N'Châu Âu', N'A'),
(NEWID(),N'Brazil nói tiếng gì?', N'Bồ Đào Nha', N'Tây Ban Nha', N'Anh', N'Pháp', N'A'),
(NEWID(),N'Nước nào nằm giữa Pháp và Tây Ban Nha?', N'Andorra', N'Monaco', N'San Marino', N'Liechtenstein', N'A'),
(NEWID(),N'Sông nào dài nhất châu Âu?', N'Volga', N'Danube', N'Rhine', N'Seine', N'A'),
(NEWID(),N'Thành phố Istabul trước kia có tên là gì?', N'Konstantinopel và Byzanz', N'Athens', N'Alexandria', N'Rome', N'A'),
(NEWID(),N'Khi mới thành lập, thành phố New York của Mỹ có tên là gì?', N'New Amsterdam', N'New London', N'New Dublin', N'New France', N'A'),
(NEWID(),N'Đỉnh núi cao nhất dãy An pơ tên là gì?', N'Mont Blanc', N'Matterhorn', N'Eiger', N'Dufourspitze', N'A'),
(NEWID(),N'Đỉnh núi cao nhất thế giới tên là gì?', N'Everest', N'K2', N'Kangchenjunga', N'Lhotse', N'A'),
(NEWID(),N'Kinh tuyến gốc đi qua Greenwich. Địa danh này nằm ở đâu?', N'Một quận của Luân Đôn', N'Paris', N'New York', N'Berlin', N'A'),
(NEWID(),N'Nước nào có nhiều núi lửa nhất thế giới?', N'Iceland', N'Indonesia', N'Nhật Bản', N'Hawaii', N'A'),
(NEWID(),N'Trước năm 1868, thủ đô Nhật tên là gì?', N'Kyoto', N'Osaka', N'Nagasaki', N'Sapporo', N'A'),
(NEWID(),N'Biển nào mặn nhất thế giới?', N'Biển Hồng Hải', N'Biển Địa Trung Hải', N'Biển Caribê', N'Biển Nhật Bản', N'A'),
(NEWID(),N'Châu lục nào nhỏ nhất thế giới?', N'Châu Úc', N'Châu Âu', N'Châu Nam Cực', N'Châu Phi', N'A'),
(NEWID(),N'Tỷ lệ đất liền chiếm bao nhiêu phần trăm bề mặt trái đất?', N'30%', N'40%', N'20%', N'50%', N'A'),
(NEWID(),N'Tên của con sông dài nhất thế giới là gì?', N'Sông Nil', N'Sông Amazon', N'Sông Mississippi', N'Sông Yangtze', N'A'),
(NEWID(),N'Cho biết tên sa mạc lớn nhất thế giới!', N'Sa mạc Sahara', N'Sa mạc Gobi', N'Sa mạc Kalahari', N'Sa mạc Mojave', N'A'),
(NEWID(),N'Bán đảo nào lớn nhất thế giới?', N'Bán đảo Ả Rập', N'Bán đảo Scandinavia', N'Bán đảo Balkan', N'Bán đảo Iberia', N'A'),
(NEWID(),N'Đường xích đạo dài bao nhiêu?', N'Khoảng 40.000 km', N'Khoảng 30.000 km', N'Khoảng 50.000 km', N'Khoảng 60.000 km', N'A'),
(NEWID(),N'Băng đảo có diện tích bao nhiêu?', N'2175600 km2', N'5000000 km2', N'1000000 km2', N'3000000 km2', N'A'),
(NEWID(),N'Thành phố nào nằm giữa hai lục địa?', N'Istanbul', N'Moscow', N'Berlin', N'Rome', N'A'),
(NEWID(),N'Sông nào có lượng nước nhiều nhất thế giới?', N'Sông Amazonas', N'Sông Congo', N'Sông Ganges', N'Sông Yangtze', N'A'),
(NEWID(),N'Sri Lanka trước kia có tên là gì?', N'Ceylon', N'Burma', N'Madagascar', N'Siam', N'A'),
(NEWID(),N'Mũi cực nam của Argentina tên là gì?', N'Đất Lửa', N'Mũi Hope', N'Mũi Horn', N'Mũi Agulhas', N'A'),
(NEWID(),N'Sa mạc Victoria nằm ở đâu?', N'Miền nam nước Úc', N'Miền bắc nước Úc', N'Miền tây nước Úc', N'Miền đông nước Úc', N'A'),
(NEWID(),N'Washington nằm bên bờ sông nào?', N'Sông Potomac', N'Sông Hudson', N'Sông Mississippi', N'Sông Missouri', N'A'),
(NEWID(),N'Quảng trường Wenzel nằm ở thành phố nào?', N'Praha', N'Berlin', N'Vienna', N'Budapest', N'A'),
(NEWID(),N'Thành phố nào có Cung điện mùa đông?', N'St. Petersburg', N'Moscow', N'Vienna', N'Berlin', N'A'),
(NEWID(),N'Capitol có ở thành phố nào?', N'Roma và Washington', N'Berlin và Paris', N'Vienna và London', N'Moscow và Tokyo', N'A'),
(NEWID(),N'Thành phố nào lớn nhất nước Úc?', N'Sydney', N'Melbourne', N'Perth', N'Brisbane', N'A'),
(NEWID(),N'Sông Themse đổ ra biển nào?', N'Biển Bắc', N'Biển Địa Trung Hải', N'Biển Baltic', N'Biển Caribê', N'A'),
(NEWID(),N'Diện tích bề mặt trái đất bao nhiêu?', N'510 triệu km2', N'600 triệu km2', N'400 triệu km2', N'700 triệu km2', N'A'),
(NEWID(),N'Hồ nước ngọt lớn nhất thế giới có tên là gì?', N'Lake Superior', N'Lake Victoria', N'Lake Tanganyika', N'Lake Baikal', N'A'),
(NEWID(),N'Tên của rặng núi cao nhất Nam Mỹ là gì?', N'Rặng Andes', N'Rặng Rockies', N'Rặng Alps', N'Rặng Himalayas', N'A'),
(NEWID(),N'Hãy cho biết tên con sông dài nhất châu Á!', N'Sông Trường Giang', N'Sông Mekong', N'Sông Amur', N'Sông Hằng', N'A'),
(NEWID(),N'Hãy cho biết tên con sông dài nhất Bắc Mỹ!', N'Sông Mississippi', N'Sông Colorado', N'Sông Yukon', N'Sông St. Lawrence', N'A'),
(NEWID(),N'Tên của sa mạc lớn nhất châu Á là gì?', N'Sa mạc Gobi', N'Sa mạc Thar', N'Sa mạc Kara-Kum', N'Sa mạc Kyzylkum', N'A'),
(NEWID(),N'Tên của đỉnh núi nổi tiếng ở Hy Lạp là gì?', N'Đỉnh Olympus', N'Đỉnh Parnassus', N'Đỉnh Pelion', N'Đỉnh Ossa', N'A');


--CREATE STORED PROCEDURE
--CREATE PROCEDURE [dbo].[CreateRecord]
--    @userId UNIQUEIDENTIFIER,
--    @questionId UNIQUEIDENTIFIER,
--    @userAnswer NVARCHAR(1)
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Check if the questionId exists in the Questions table
--    IF NOT EXISTS (SELECT 1 FROM [dbo].[Questions] WHERE [questionId] = @questionId)
--    BEGIN
--        RAISERROR('Invalid questionId.', 16, 1);
--        RETURN;
--    END

--    -- Check if the userId exists in the Users table
--    IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [userId] = @userId)
--    BEGIN
--        RAISERROR('Invalid userId.', 16, 1);
--        RETURN;
--    END

--    -- Insert the new record into the Records table
--    INSERT INTO [dbo].[Records] ([recordId], [userId], [userAnswer], [questionId])
--    VALUES (NEWID(), @userId, @userAnswer, @questionId);

--    PRINT 'Record created successfully.';
--END
--GO

---- USING PROCEDURE
--DECLARE @userId UNIQUEIDENTIFIER;
--SELECT TOP 1 @userId = [userId] FROM [dbo].[Users] WHERE LTRIM(RTRIM(username)) = 'phongluu';
--    PRINT 'UserId: ' + CAST(@userId AS NVARCHAR(36));

--DECLARE @questionId UNIQUEIDENTIFIER;
--SELECT TOP 1 @questionId = [questionId] FROM [dbo].[Questions] WHERE question = 'HIHI';
--	PRINT 'QuestionId: ' + CAST(@questionId AS NVARCHAR(MAX));

--DECLARE @userAnswer NVARCHAR(1) = 'A';
--	PRINT 'UserAnswer: ' + @userAnswer;
--EXEC [dbo].[CreateRecord] @userId, @questionId, @userAnswer;

----Check Procedure
--EXEC sp_helptext 'CreateRecord';

----DROP STORED PROCEDURE
--USE [QuestionWarehouse];
--GO
--DROP PROCEDURE [dbo].[CreateRecord];

--DECLARE @userId UNIQUEIDENTIFIER = '316395d4-f1af-46f7-947b-a4021b670c07'
