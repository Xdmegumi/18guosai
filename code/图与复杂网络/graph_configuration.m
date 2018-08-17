plot([1:10],'--o','color',[0.5,0.3,0.5],'LineWidth',2);
hold on;
plot([2:11]);

title('0');
xlabel('1');
ylabel('2');

legend('3','4');

text(5,5,'\leftarrow 5')
txt = texlabel('y = x');%设置具有 TeX 字符的文本的格式
text(6,6,txt);
%gtext('7');

xlim([2,8]);

xticks([2 5 8])
xticklabels({'x = 2','x = 5','x = 8'})
