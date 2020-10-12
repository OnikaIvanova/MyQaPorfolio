#Брой на потребители
select COUNT(*) from users;

#Най-стария потребител
select * from users 
order by  birthDate limit 1;

#Най-младия потребител
select * from users 
order by  birthDate desc limit 1;

#Колко юзъра са регистрирани с мейли от abv и колко от gmail и колко с различни от двата.
select count(*) from users 
where email like '%abv%'
union
select count(*) from users 
where email like '%gmail%'
union all
select count(*) from users 
where email not like '%gmail%' and email not like '%abv%';

#Кои юзъри са banned
select * from users
where isBanned !=0;

#Изкарайте всички потребители от базата като ги наредите по име в азбучен ред и дата на раждане(от най-младия към най-възрастния).
select username,birthDate from users
order by username asc , birthDate desc;

#Изкарайте всички потребители от базата, на които потребителското име започва с a.
select * from users
where username like 'A%';

#Изкарайте всички потребители от базата, които съдържат а username името си.
select * from users
where username like '%a%';

# Регистрирайте 1 юзър през UI-а и го забранете след това от базата.
update users
set isBanned ="1"
where username = "AuserUI";
#Брой на всички постове
select count(*) from posts;
#Брой на всички постове групирани по статуса на post-a
select postStatus, count(*) 
from posts
group by postStatus;
#Намерете поста/овете с най-къс caption.
select min(caption) from posts;

# Покажете поста с най-дълъг caption
select max(caption) from posts;

# Кой потребител има най-много постове. Използвайте join заявка
select * from users u
right join posts p
on u.id = p.userid
order by count(p.userId)
limit 3;

#Кои са постовете с най-много коментари. Използвайте вложена заявка и where clause
select * from posts
 order by commentsCount desc
 limit 3;
# Покажете най-стария пост. Може да използвате order или с aggregate function.
select * from posts
order by createdAt 
limit 1;

# Покажете най-новия пост. Може с order или с aggregate function.
select * from posts
order by createdAt desc
limit 1;

# Покажете всички постове с празен caption
select * from posts
where caption like '';


#Покажете всички постове и коментарите им ако имат такива
select p.caption,c.content from posts p
inner join comments c
    on p.id = c.id;    
# Покажете само постове с коментари и самите коментари.
select p.caption,c.content from posts p
right join comments c
    on p.id = c.id;

# Покажете всички коментари, към кой пост принадлежат и кой ги е направил.Използвайте join клауза.
select c.id, c.content,p.id,p.caption,u.id, u.username from comments c
inner join posts p
   on c.postid = p.id
inner join users u
   on u.id = c.userid;
   
#  Кои потребители не са like-вали постове.
select u.username,ulp.usersId from users u
 left join users_liked_posts ulp
   on u.id = ulp.usersId
   group by u.username
   having ulp.usersId is null;

# Кои постове имат like-ове. Покажете id на поста и caption
select p.id,p.caption from posts p
right join users_liked_posts ulp
   on p.id = ulp.postsId;
